import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/notificacion_stock.dart';
import '../../repositories/notificacion_repository.dart';

/// HU-04.6 · Consulta el historial de notificaciones de stock crítico.
class ConsultarNotificacionesUseCase {
  final NotificacionRepository _repo;
  const ConsultarNotificacionesUseCase(this._repo);

  Future<Either<Failure, List<NotificacionStock>>> call({
    DateTime? desde,
    DateTime? hasta,
  }) =>
      _repo.historial(desde: desde, hasta: hasta);
}
