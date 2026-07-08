import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../core/services/connectivity_service.dart';
import '../../domain/entities/ciclo.dart';
import '../../domain/entities/enums.dart';
import '../../domain/repositories/ciclo_repository.dart';
import '../local/ciclo_local_mapper.dart';
import '../local/inventario_local_service.dart';
import '../local/isar_service.dart';
import '../local/models/ciclo_local.dart';
import '../models/ciclo_dto.dart';
import '../remote/supabase_types.dart';

/// Implementación de [CicloRepository] sobre Supabase, con caché local en Isar
/// y soporte offline (HU-02.5).
///
/// - **Online**: inserta el ciclo en Supabase (el trigger
///   `fn_descontar_insumos_por_ciclo` descuenta el inventario server-side) y
///   refleja el descuento en la caché local de inmediato (<1 s).
/// - **Offline**: registra el ciclo solo en Isar con `sincronizado = false` y
///   aplica el descuento de insumos localmente, encolando los movimientos para
///   la sincronización posterior (HU-03.5).
class CicloRepositoryImpl implements CicloRepository {
  final SupabaseClient _supabase;
  final IsarService _isar;
  final ConnectivityService _connectivity;
  final InventarioLocalService _inventarioLocal;
  static const _uuid = Uuid();

  const CicloRepositoryImpl(
    this._supabase,
    this._isar,
    this._connectivity,
    this._inventarioLocal,
  );

  @override
  Future<Either<Failure, Ciclo>> iniciar({
    required String usuarioId,
    required String clienteId,
    required String programaId,
    required String? turnoId,
    required int duracionMinutos,
    String? programaNombre,
    String? clienteNombre,
  }) async {
    final inicioEn = DateTime.now();
    final online = await _connectivity.estaEnLinea();

    if (!online) {
      // ---- Camino offline (HU-02.5 / HU-03.5) ----
      final ciclo = Ciclo(
        id: _uuid.v4(),
        usuarioId: usuarioId,
        clienteId: clienteId,
        programaId: programaId,
        turnoId: turnoId,
        inicioEn: inicioEn,
        estado: EstadoCiclo.enCurso,
        sincronizado: false,
        duracionMinutos: duracionMinutos,
        programaNombre: programaNombre,
        clienteNombre: clienteNombre,
      );
      await _cachear(ciclo);
      await _inventarioLocal.aplicarDescuento(
        programaId: programaId,
        usuarioId: usuarioId,
        cicloId: ciclo.id,
        offline: true,
        momento: inicioEn,
      );
      return Right(ciclo);
    }

    // ---- Camino online ----
    try {
      final row = await _supabase
          .from(Tablas.ciclos)
          .insert(CicloDto.toInsert(
            usuarioId: usuarioId,
            clienteId: clienteId,
            programaId: programaId,
            turnoId: turnoId,
            inicioEn: inicioEn,
          ))
          .select(CicloDto.select)
          .single();

      final ciclo = _conNombres(
        CicloDto.fromJson(row),
        duracionMinutos: duracionMinutos,
        programaNombre: programaNombre,
        clienteNombre: clienteNombre,
      );
      await _cachear(ciclo);
      // Refleja el descuento en la caché local de inmediato (el trigger ya lo
      // hizo en el servidor; Realtime reconciliará los valores autoritativos).
      await _inventarioLocal.aplicarDescuento(
        programaId: programaId,
        usuarioId: usuarioId,
        cicloId: ciclo.id,
        offline: false,
        momento: inicioEn,
      );
      return Right(ciclo);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, Ciclo>> cerrar(String cicloId) async {
    final online = await _connectivity.estaEnLinea();
    final finEn = DateTime.now();

    if (!online) {
      // Cierra localmente; se sincronizará luego.
      final local = await _isar.ciclos.getByIndex('id', [cicloId]);
      if (local == null) {
        return const Left(CacheFailure(S.errorGenerico));
      }
      local
        ..finEn = finEn
        ..estado = EstadoCiclo.completado.wire
        ..sincronizado = false;
      await _isar.isar.writeTxn(() async {
        await _isar.ciclos.put(local);
      });
      return Right(CicloLocalMapper.toEntity(local));
    }

    try {
      final row = await _supabase
          .from(Tablas.ciclos)
          .update({
            ColCiclo.finEn: finEn.toUtc().toIso8601String(),
            ColCiclo.estado: EstadoCiclo.completado.wire,
          })
          .eq(ColCiclo.id, cicloId)
          .select(CicloDto.select)
          .single();
      final ciclo = CicloDto.fromJson(row);
      await _cachear(ciclo);
      return Right(ciclo);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, List<Ciclo>>> listarPorUsuario(String usuarioId) async {
    try {
      final rows = await _supabase
          .from(Tablas.ciclos)
          .select(CicloDto.select)
          .eq(ColCiclo.usuarioId, usuarioId)
          .order(ColCiclo.inicioEn, ascending: false);
      final ciclos =
          rows.cast<Map<String, dynamic>>().map(CicloDto.fromJson).toList();
      return Right(ciclos);
    } catch (_) {
      // Fallback offline: historial desde Isar.
      final locales =
          await _isar.ciclos.filter().usuarioIdEqualTo(usuarioId).findAll();
      if (locales.isNotEmpty) {
        final ciclos = locales.map(CicloLocalMapper.toEntity).toList()
          ..sort((a, b) => b.inicioEn.compareTo(a.inicioEn));
        return Right(ciclos);
      }
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, Ciclo?>> cicloEnCurso(String usuarioId) async {
    // Primero revisa la caché local (cubre ciclos iniciados offline).
    final localEnCurso = await _isar.ciclos
        .filter()
        .usuarioIdEqualTo(usuarioId)
        .estadoEqualTo(EstadoCiclo.enCurso.wire)
        .sortByInicioEnDesc()
        .findFirst();
    if (localEnCurso != null && !localEnCurso.sincronizado) {
      return Right(CicloLocalMapper.toEntity(localEnCurso));
    }

    try {
      final row = await _supabase
          .from(Tablas.ciclos)
          .select(CicloDto.select)
          .eq(ColCiclo.usuarioId, usuarioId)
          .eq(ColCiclo.estado, EstadoCiclo.enCurso.wire)
          .order(ColCiclo.inicioEn, ascending: false)
          .limit(1)
          .maybeSingle();
      if (row != null) return Right(CicloDto.fromJson(row));
      // Sin conexión o sin remoto: usa el local si existe.
      return Right(localEnCurso == null
          ? null
          : CicloLocalMapper.toEntity(localEnCurso));
    } catch (_) {
      return Right(localEnCurso == null
          ? null
          : CicloLocalMapper.toEntity(localEnCurso));
    }
  }

  Ciclo _conNombres(
    Ciclo base, {
    required int duracionMinutos,
    String? programaNombre,
    String? clienteNombre,
  }) {
    return Ciclo(
      id: base.id,
      usuarioId: base.usuarioId,
      clienteId: base.clienteId,
      programaId: base.programaId,
      turnoId: base.turnoId,
      inicioEn: base.inicioEn,
      finEn: base.finEn,
      estado: base.estado,
      sincronizado: base.sincronizado,
      duracionMinutos:
          base.duracionMinutos != 0 ? base.duracionMinutos : duracionMinutos,
      programaNombre: base.programaNombre ?? programaNombre,
      clienteNombre: base.clienteNombre ?? clienteNombre,
    );
  }

  Future<void> _cachear(Ciclo ciclo) async {
    final local = CicloLocalMapper.fromEntity(ciclo);
    await _isar.isar.writeTxn(() async {
      await _isar.ciclos.putByIndex('id', local);
    });
  }
}
