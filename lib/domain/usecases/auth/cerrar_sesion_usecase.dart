import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/auth_repository.dart';

/// HU-01.3 · Cierra la sesión y limpia el almacenamiento seguro.
class CerrarSesionUseCase {
  final AuthRepository _repo;
  const CerrarSesionUseCase(this._repo);

  Future<Either<Failure, void>> call() => _repo.cerrarSesion();
}
