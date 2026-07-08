import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/notificacion_stock.dart';

/// Contrato del historial de notificaciones de stock crítico (HU-04.6).
abstract interface class NotificacionRepository {
  Future<Either<Failure, List<NotificacionStock>>> historial({
    DateTime? desde,
    DateTime? hasta,
  });
}
