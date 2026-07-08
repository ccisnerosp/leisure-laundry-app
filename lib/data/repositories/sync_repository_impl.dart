import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/enums.dart';
import '../../domain/repositories/sync_repository.dart';
import '../local/isar_service.dart';
import '../local/models/ciclo_local.dart';
import '../local/models/movimiento_inventario_local.dart';
import '../remote/supabase_types.dart';

/// Sincronización bidireccional offline → Supabase (HU-02.5 / HU-03.5).
///
/// Orden: primero ciclos, luego movimientos. Para cada ciclo offline se hace un
/// INSERT en estado `en_curso` para que el trigger del servidor
/// `fn_descontar_insumos_por_ciclo` ejecute el descuento autoritativo y cree los
/// movimientos `descuento` del servidor; si el ciclo se completó offline, se
/// aplica luego un UPDATE de cierre. Los movimientos `descuento` locales se
/// reconcilian (se marcan sincronizados sin reenviarse) para evitar doble
/// descuento. Resolución de conflictos por timestamp: el registro más reciente
/// gana (los ciclos creados offline no existen aún en el servidor → se insertan).
class SyncRepositoryImpl implements SyncRepository {
  final SupabaseClient _supabase;
  final IsarService _isar;
  const SyncRepositoryImpl(this._supabase, this._isar);

  @override
  Future<int> pendientes() async {
    final ciclos =
        await _isar.ciclos.filter().sincronizadoEqualTo(false).count();
    final movs =
        await _isar.movimientos.filter().sincronizadoEqualTo(false).count();
    return ciclos + movs;
  }

  @override
  Future<Either<Failure, SyncResultado>> sincronizar() async {
    try {
      var ciclosOk = 0;
      var movsOk = 0;

      // ---- 1) Ciclos pendientes (orden cronológico) ----
      final ciclosPend = await _isar.ciclos
          .filter()
          .sincronizadoEqualTo(false)
          .sortByInicioEn()
          .findAll();

      for (final c in ciclosPend) {
        // INSERT en 'en_curso' para disparar el trigger de descuento.
        try {
          await _supabase.from(Tablas.ciclos).insert({
            ColCiclo.id: c.id,
            ColCiclo.usuarioId: c.usuarioId,
            ColCiclo.clienteId: c.clienteId,
            ColCiclo.programaId: c.programaId,
            if (c.turnoId != null) ColCiclo.turnoId: c.turnoId,
            ColCiclo.inicioEn: c.inicioEn.toUtc().toIso8601String(),
            ColCiclo.estado: EstadoCiclo.enCurso.wire,
            ColCiclo.sincronizado: true,
          });
        } on PostgrestException catch (e) {
          // 23505 = clave duplicada → ya se insertó en un intento previo.
          if (e.code != '23505') rethrow;
        }

        // Si se completó offline, aplica el cierre.
        if (c.estado == EstadoCiclo.completado.wire && c.finEn != null) {
          await _supabase.from(Tablas.ciclos).update({
            ColCiclo.finEn: c.finEn!.toUtc().toIso8601String(),
            ColCiclo.estado: EstadoCiclo.completado.wire,
          }).eq(ColCiclo.id, c.id);
        }

        // Marca el ciclo local como sincronizado.
        await _isar.isar.writeTxn(() async {
          c.sincronizado = true;
          await _isar.ciclos.put(c);
        });

        // Reconcilia los movimientos 'descuento' de este ciclo: el trigger ya
        // creó los autoritativos en el servidor; solo se marcan sincronizados.
        final movsCiclo = await _isar.movimientos
            .filter()
            .cicloIdEqualTo(c.id)
            .sincronizadoEqualTo(false)
            .findAll();
        if (movsCiclo.isNotEmpty) {
          await _isar.isar.writeTxn(() async {
            for (final m in movsCiclo) {
              m.sincronizado = true;
              await _isar.movimientos.put(m);
            }
          });
          movsOk += movsCiclo.length;
        }
        ciclosOk++;
      }

      // ---- 2) Movimientos sueltos no-'descuento' (ingresos/ajustes offline) ----
      final movsSueltos = await _isar.movimientos
          .filter()
          .sincronizadoEqualTo(false)
          .findAll();
      for (final m in movsSueltos) {
        if (m.tipo == 'descuento') continue; // pertenece a un ciclo
        await _supabase.from(Tablas.movimientosInventario).insert({
          ColMovimiento.id: m.id,
          ColMovimiento.insumoId: m.insumoId,
          if (m.cicloId != null) ColMovimiento.cicloId: m.cicloId,
          ColMovimiento.usuarioId: m.usuarioId,
          ColMovimiento.tipo: m.tipo,
          ColMovimiento.cantidad: m.cantidad,
          ColMovimiento.stockResultante: m.stockResultante,
          ColMovimiento.registradoEn: m.registradoEn.toUtc().toIso8601String(),
          ColMovimiento.sincronizado: true,
        });
        await _isar.isar.writeTxn(() async {
          m.sincronizado = true;
          await _isar.movimientos.put(m);
        });
        movsOk++;
      }

      return Right(SyncResultado(
        ciclosSincronizados: ciclosOk,
        movimientosSincronizados: movsOk,
      ));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
