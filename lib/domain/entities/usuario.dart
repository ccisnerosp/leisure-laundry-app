import 'enums.dart';

/// Usuario autenticado de la app (operario o gerencial). Mapea la tabla
/// `usuarios`. Nunca transporta el `password_hash`.
class Usuario {
  final String id;
  final String email;
  final String nombre;
  final RolUsuario rol;

  /// TRUE si debe cambiar su contraseña en el próximo login (HU-05.3).
  final bool passwordTemporal;
  final bool activo;

  const Usuario({
    required this.id,
    required this.email,
    required this.nombre,
    required this.rol,
    this.passwordTemporal = false,
    this.activo = true,
  });

  bool get esGerencial => rol == RolUsuario.gerencial;
  bool get esOperario => rol == RolUsuario.operario;

  Usuario copyWith({bool? passwordTemporal, bool? activo}) => Usuario(
        id: id,
        email: email,
        nombre: nombre,
        rol: rol,
        passwordTemporal: passwordTemporal ?? this.passwordTemporal,
        activo: activo ?? this.activo,
      );
}
