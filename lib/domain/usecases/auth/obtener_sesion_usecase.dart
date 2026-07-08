import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';
import '../../repositories/auth_repository.dart';

/// HU-01.3 · Recupera la sesión persistida al abrir la app. Devuelve `null` si
/// no hay sesión activa.
class ObtenerSesionUseCase {
  final AuthRepository _repo;
  const ObtenerSesionUseCase(this._repo);

  Future<Either<Failure, Usuario?>> call() => _repo.usuarioActual();
}
