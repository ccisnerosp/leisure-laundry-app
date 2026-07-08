import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/insumo.dart';
import '../../domain/repositories/insumo_repository.dart';
import '../local/inventario_local_mapper.dart';
import '../local/isar_service.dart';
import '../models/insumo_dto.dart';
import '../remote/supabase_types.dart';

class InsumoRepositoryImpl implements InsumoRepository {
  final SupabaseClient _supabase;
  final IsarService _isar;
  const InsumoRepositoryImpl(this._supabase, this._isar);

  @override
  Future<Either<Failure, List<Insumo>>> listar({bool soloActivos = true}) async {
    try {
      var query = _supabase.from(Tablas.insumos).select();
      if (soloActivos) {
        query = query.eq(ColInsumo.activo, true);
      }
      final rows = await query.order(ColInsumo.nombre);
      final insumos =
          rows.cast<Map<String, dynamic>>().map(InsumoDto.fromJson).toList();
      await _cachear(insumos);
      return Right(insumos);
    } catch (_) {
      // Fallback offline: lee la caché local de Isar (HU-03.5).
      final locales = await _isar.insumos.where().findAll();
      if (locales.isNotEmpty) {
        final insumos = locales
            .map(InsumoLocalMapper.toEntity)
            .where((i) => !soloActivos || i.activo)
            .toList()
          ..sort((a, b) => a.nombre.compareTo(b.nombre));
        return Right(insumos);
      }
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, Insumo>> registrarIngreso({
    required String insumoId,
    required double cantidad,
    required String usuarioId,
  }) async {
    try {
      // 1) Lee el stock actual.
      final actual = await _supabase
          .from(Tablas.insumos)
          .select()
          .eq(ColInsumo.id, insumoId)
          .single();
      final insumo = InsumoDto.fromJson(actual);
      final nuevoStock = insumo.stockActual + cantidad;

      // 2) Actualiza el stock.
      final updated = await _supabase
          .from(Tablas.insumos)
          .update({ColInsumo.stockActual: nuevoStock})
          .eq(ColInsumo.id, insumoId)
          .select()
          .single();

      // 3) Registra el movimiento de ingreso (fecha, hora y usuario).
      await _supabase.from(Tablas.movimientosInventario).insert({
        ColMovimiento.insumoId: insumoId,
        ColMovimiento.usuarioId: usuarioId,
        ColMovimiento.tipo: TipoMovimiento.ingreso.wire,
        ColMovimiento.cantidad: cantidad,
        ColMovimiento.stockResultante: nuevoStock,
      });

      final resultado = InsumoDto.fromJson(updated);
      await _cachear([resultado]);
      return Right(resultado);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, Insumo>> actualizarUmbral({
    required String insumoId,
    required double umbral,
  }) async {
    try {
      final row = await _supabase
          .from(Tablas.insumos)
          .update({ColInsumo.umbralMinimo: umbral})
          .eq(ColInsumo.id, insumoId)
          .select()
          .single();
      final insumo = InsumoDto.fromJson(row);
      await _cachear([insumo]);
      return Right(insumo);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  Future<void> _cachear(List<Insumo> insumos) async {
    await _isar.isar.writeTxn(() async {
      for (final i in insumos) {
        await _isar.insumos.putByIndex('id', InsumoLocalMapper.fromEntity(i));
      }
    });
  }
}
