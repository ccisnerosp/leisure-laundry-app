import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/enums.dart';
import '../entities/usuario.dart';

/// Contrato de gestión de usuarios operarios/gerenciales (HU-05.3).
abstract interface class UsuarioRepository {
  Future<Either<Failure, List<Usuario>>> listar();

  /// Crea un usuario con contraseña inicial temporal. El usuario será obligado
  /// a cambiarla en su primer inicio de sesión (`password_temporal = true`).
  Future<Either<Failure, Usuario>> crear({
    required String nombre,
    required String email,
    required RolUsuario rol,
    required String passwordInicial,
  });

  /// Activa o desactiva un usuario sin eliminar su historial.
  Future<Either<Failure, void>> cambiarEstado(String id, {required bool activo});
}
