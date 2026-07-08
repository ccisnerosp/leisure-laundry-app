import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/estado_inventario_item.dart';
import '../../repositories/dashboard_repository.dart';

/// HU-04.1 · Estado del inventario con clasificación de stock.
class ObtenerEstadoInventarioUseCase {
  final DashboardRepository _repo;
  const ObtenerEstadoInventarioUseCase(this._repo);

  Future<Either<Failure, List<EstadoInventarioItem>>> call() =>
      _repo.estadoInventario();
}
