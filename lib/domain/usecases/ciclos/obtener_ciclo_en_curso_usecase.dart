import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/ciclo.dart';
import '../../repositories/ciclo_repository.dart';

/// HU-02.2 · Recupera el ciclo en curso del usuario para reanudar el
/// temporizador tras reabrir la app (el conteo se calcula desde `inicio_en`).
class ObtenerCicloEnCursoUseCase {
  final CicloRepository _repo;
  const ObtenerCicloEnCursoUseCase(this._repo);

  Future<Either<Failure, Ciclo?>> call(String usuarioId) =>
      _repo.cicloEnCurso(usuarioId);
}
