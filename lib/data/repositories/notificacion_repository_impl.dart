import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/notificacion_stock.dart';
import '../../domain/repositories/notificacion_repository.dart';
import '../models/notificacion_dto.dart';
import '../remote/supabase_types.dart';

class NotificacionRepositoryImpl implements NotificacionRepository {
  final SupabaseClient _supabase;
  const NotificacionRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<NotificacionStock>>> historial({
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      var query =
          _supabase.from(Tablas.notificacionesStock).select(NotificacionDto.select);
      if (desde != null) {
        query = query.gte(
            ColNotificacion.generadaEn, desde.toUtc().toIso8601String());
      }
      if (hasta != null) {
        query = query.lte(
            ColNotificacion.generadaEn, hasta.toUtc().toIso8601String());
      }
      final rows =
          await query.order(ColNotificacion.generadaEn, ascending: false);
      final data = rows
          .cast<Map<String, dynamic>>()
          .map(NotificacionDto.fromJson)
          .toList();
      return Right(data);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }
}
