import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/movimiento_inventario.dart';
import '../../domain/repositories/movimiento_repository.dart';
import '../models/movimiento_dto.dart';
import '../remote/supabase_types.dart';

class MovimientoRepositoryImpl implements MovimientoRepository {
  final SupabaseClient _supabase;
  const MovimientoRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<MovimientoInventario>>> historial(
      FiltroMovimientos filtro) async {
    try {
      var query =
          _supabase.from(Tablas.movimientosInventario).select(MovimientoDto.select);

      if (filtro.insumoId != null) {
        query = query.eq(ColMovimiento.insumoId, filtro.insumoId!);
      }
      if (filtro.desde != null) {
        query = query.gte(
            ColMovimiento.registradoEn, filtro.desde!.toUtc().toIso8601String());
      }
      if (filtro.hasta != null) {
        query = query.lte(
            ColMovimiento.registradoEn, filtro.hasta!.toUtc().toIso8601String());
      }

      final rows = await query.order(ColMovimiento.registradoEn, ascending: false);
      var lista = rows.cast<Map<String, dynamic>>();

      // Filtro por turno: el turno vive en el ciclo asociado (embebido).
      if (filtro.turnoId != null) {
        lista = lista
            .where((r) => MovimientoDto.turnoIdDe(r) == filtro.turnoId)
            .toList();
      }

      final movimientos = lista.map(MovimientoDto.fromJson).toList();
      return Right(movimientos);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }
}
