import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/ciclo.dart';
import '../../repositories/dashboard_repository.dart';

/// HU-04.1 · Ciclos actualmente en curso (todos los operarios).
class ObtenerCiclosActivosUseCase {
  final DashboardRepository _repo;
  const ObtenerCiclosActivosUseCase(this._repo);

  Future<Either<Failure, List<Ciclo>>> call() => _repo.ciclosActivos();
}
