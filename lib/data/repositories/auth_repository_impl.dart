import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/usuario_dto.dart';
import '../remote/supabase_types.dart';

/// Implementación de [AuthRepository] sobre Supabase Auth + tabla `usuarios`.
///
/// El login usa Supabase Auth (email/contraseña). El rol y el flag
/// `password_temporal` se resuelven leyendo el perfil en `usuarios` cuyo `id`
/// coincide con el `auth.uid()`.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;
  const AuthRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, Usuario>> iniciarSesion({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final authUser = res.user;
      if (authUser == null) {
        return const Left(AuthFailure(S.loginErrorCredenciales));
      }
      return _cargarPerfil(authUser.id);
    } on AuthException {
      // No se revela si fue el correo o la contraseña (HU-01.1).
      return const Left(AuthFailure(S.loginErrorCredenciales));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, Usuario?>> usuarioActual() async {
    final session = _supabase.auth.currentSession;
    final authUser = _supabase.auth.currentUser;
    if (session == null || authUser == null) {
      return const Right(null);
    }
    final perfil = await _cargarPerfil(authUser.id);
    return perfil.fold(
      (f) => Left(f),
      (u) => Right(u),
    );
  }

  @override
  Future<Either<Failure, void>> cerrarSesion() async {
    try {
      await _supabase.auth.signOut();
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, void>> cambiarPassword(String nuevaPassword) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return const Left(AuthFailure(S.loginErrorCredenciales));
      }
      await _supabase.auth.updateUser(UserAttributes(password: nuevaPassword));
      // Limpia el flag de contraseña temporal en el perfil (HU-05.3).
      await _supabase
          .from(Tablas.usuarios)
          .update({ColUsuario.passwordTemporal: false}).eq(
              ColUsuario.id, authUser.id);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  /// Lee el perfil de `usuarios` y lo mapea a [Usuario].
  Future<Either<Failure, Usuario>> _cargarPerfil(String authId) async {
    try {
      final row = await _supabase
          .from(Tablas.usuarios)
          .select()
          .eq(ColUsuario.id, authId)
          .maybeSingle();
      if (row == null) {
        return const Left(
            AuthFailure('Tu usuario no tiene perfil asignado. Contacta al administrador.'));
      }
      final usuario = UsuarioDto.fromJson(row);
      if (!usuario.activo) {
        return const Left(AuthFailure('Tu usuario está desactivado.'));
      }
      return Right(usuario);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
