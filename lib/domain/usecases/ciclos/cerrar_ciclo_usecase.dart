import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/ciclo.dart';
import '../../repositories/ciclo_repository.dart';

/// HU-02.4 · Cierra el ciclo registrando la hora de fin y estado `completado`
/// cuando el operario confirma el retiro de prendas.
class CerrarCicloUseCase {
  final CicloRepository _repo;
  const CerrarCicloUseCase(this._repo);

  Future<Either<Failure, Ciclo>> call(String cicloId) => _repo.cerrar(cicloId);
}
