import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/usuario.dart';
import '../../repositories/auth_repository.dart';

/// HU-01.1 · Inicia sesión con credenciales validando el formato de entrada
/// antes de llamar al backend.
class IniciarSesionUseCase {
  final AuthRepository _repo;
  const IniciarSesionUseCase(this._repo);

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  Future<Either<Failure, Usuario>> call({
    required String email,
    required String password,
  }) {
    final correo = email.trim();
    if (correo.isEmpty) {
      return Future.value(const Left(ValidationFailure(S.loginErrorCorreoVacio)));
    }
    if (!_emailRegex.hasMatch(correo)) {
      return Future.value(
          const Left(ValidationFailure(S.loginErrorCorreoInvalido)));
    }
    if (password.isEmpty) {
      return Future.value(
          const Left(ValidationFailure(S.loginErrorPasswordVacio)));
    }
    return _repo.iniciarSesion(email: correo, password: password);
  }
}
