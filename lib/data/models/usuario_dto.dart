import '../../domain/entities/enums.dart';
import '../../domain/entities/usuario.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `usuarios` (Supabase JSON) y la entidad [Usuario].
class UsuarioDto {
  static Usuario fromJson(Map<String, dynamic> j) => Usuario(
        id: j[ColUsuario.id] as String,
        email: j[ColUsuario.email] as String,
        nombre: j[ColUsuario.nombre] as String,
        rol: RolUsuario.fromWire(j[ColUsuario.rol] as String),
        passwordTemporal: (j[ColUsuario.passwordTemporal] as bool?) ?? false,
        activo: (j[ColUsuario.activo] as bool?) ?? true,
      );

  /// para INSERT de un nuevo usuario (HU-05.3). No incluye `password_hash`,
  /// que se gestiona vía Supabase Auth.
  static Map<String, dynamic> toInsert({
    required String id,
    required String nombre,
    required String email,
    required RolUsuario rol,
  }) =>
      {
        ColUsuario.id: id,
        ColUsuario.nombre: nombre,
        ColUsuario.email: email,
        ColUsuario.rol: rol.wire,
        ColUsuario.passwordTemporal: true,
        ColUsuario.activo: true,
      };
}
