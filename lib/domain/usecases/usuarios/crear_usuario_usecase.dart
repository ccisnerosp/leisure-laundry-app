import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/enums.dart';
import '../../entities/usuario.dart';
import '../../repositories/usuario_repository.dart';

/// HU-05.3 · Crea un usuario con contraseña inicial temporal.
class CrearUsuarioUseCase {
  final UsuarioRepository _repo;
  const CrearUsuarioUseCase(this._repo);

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  Future<Either<Failure, Usuario>> call({
    required String nombre,
    required String email,
    required RolUsuario rol,
    required String passwordInicial,
  }) {
    final n = nombre.trim();
    final correo = email.trim();
    if (n.isEmpty) {
      return Future.value(const Left(ValidationFailure(S.usuarioErrorNombre)));
    }
    if (!_emailRegex.hasMatch(correo)) {
      return Future.value(const Left(ValidationFailure(S.usuarioErrorCorreo)));
    }
    if (passwordInicial.length < 6) {
      return Future.value(const Left(ValidationFailure(S.usuarioErrorPassword)));
    }
    return _repo.crear(
      nombre: n,
      email: correo,
      rol: rol,
      passwordInicial: passwordInicial,
    );
  }
}
