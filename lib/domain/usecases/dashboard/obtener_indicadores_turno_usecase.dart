import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/indicador_turno.dart';
import '../../repositories/dashboard_repository.dart';

/// HU-04.2 · Indicadores del turno en curso.
class ObtenerIndicadoresTurnoUseCase {
  final DashboardRepository _repo;
  const ObtenerIndicadoresTurnoUseCase(this._repo);

  Future<Either<Failure, List<IndicadorTurno>>> call() =>
      _repo.indicadoresTurno();
}
