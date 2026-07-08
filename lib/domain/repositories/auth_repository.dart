import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/usuario.dart';

/// Contrato de autenticación. La implementación (data/) usa Supabase Auth +
/// la tabla `usuarios` para resolver el perfil/rol. presentation/ jamás conoce
/// Supabase.
abstract interface class AuthRepository {
  /// Autentica con correo y contraseña. Devuelve el [Usuario] con su rol.
  Future<Either<Failure, Usuario>> iniciarSesion({
    required String email,
    required String password,
  });

  /// Devuelve el usuario de la sesión persistida, o `null` si no hay sesión.
  Future<Either<Failure, Usuario?>> usuarioActual();

  /// Cierra la sesión y limpia el almacenamiento seguro.
  Future<Either<Failure, void>> cerrarSesion();

  /// Cambia la contraseña del usuario autenticado y marca
  /// `password_temporal = false` (HU-05.3).
  Future<Either<Failure, void>> cambiarPassword(String nuevaPassword);
}
