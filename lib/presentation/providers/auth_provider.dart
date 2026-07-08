import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/usuario.dart';
import 'usecase_providers.dart';

/// Estado de autenticación de la app.
sealed class AuthState {
  const AuthState();
}

/// Cargando (verificando sesión persistida al arrancar).
class AuthCargando extends AuthState {
  const AuthCargando();
}

/// Sin sesión: mostrar login.
class AuthNoAutenticado extends AuthState {
  /// Mensaje de error a mostrar (p. ej. credenciales inválidas), si aplica.
  final Failure? error;
  const AuthNoAutenticado({this.error});
}

/// Autenticado pero con contraseña temporal: forzar cambio (HU-05.3).
class AuthRequiereCambioPassword extends AuthState {
  final Usuario usuario;
  const AuthRequiereCambioPassword(this.usuario);
}

/// Sesión activa lista para operar.
class AuthAutenticado extends AuthState {
  final Usuario usuario;
  const AuthAutenticado(this.usuario);
}

class AuthController extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthController(this._ref) : super(const AuthCargando());

  /// HU-01.3 · Restaura la sesión persistida al iniciar la app.
  Future<void> cargarSesion() async {
    state = const AuthCargando();
    final res = await _ref.read(obtenerSesionUseCaseProvider).call();
    state = res.fold(
      (f) => const AuthNoAutenticado(),
      (usuario) => usuario == null
          ? const AuthNoAutenticado()
          : _estadoSegunUsuario(usuario),
    );
  }

  /// HU-01.1 · Inicia sesión con credenciales.
  Future<void> iniciarSesion(String email, String password) async {
    state = const AuthCargando();
    final res = await _ref
        .read(iniciarSesionUseCaseProvider)
        .call(email: email, password: password);
    state = res.fold(
      (f) => AuthNoAutenticado(error: f),
      (usuario) => _estadoSegunUsuario(usuario),
    );
  }

  /// HU-05.3 · Confirma el cambio de contraseña temporal.
  Future<Failure?> cambiarPassword(String nueva, String confirmacion) async {
    final res = await _ref
        .read(cambiarPasswordUseCaseProvider)
        .call(nueva: nueva, confirmacion: confirmacion);
    return res.fold(
      (f) => f,
      (_) {
        final actual = state;
        if (actual is AuthRequiereCambioPassword) {
          state = AuthAutenticado(
              actual.usuario.copyWith(passwordTemporal: false));
        }
        return null;
      },
    );
  }

  /// HU-01.3 · Cierra la sesión.
  Future<void> cerrarSesion() async {
    await _ref.read(cerrarSesionUseCaseProvider).call();
    state = const AuthNoAutenticado();
  }

  AuthState _estadoSegunUsuario(Usuario usuario) => usuario.passwordTemporal
      ? AuthRequiereCambioPassword(usuario)
      : AuthAutenticado(usuario);
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

/// Usuario autenticado actual (o null). Útil para las pantallas.
final usuarioActualProvider = Provider<Usuario?>((ref) {
  final s = ref.watch(authControllerProvider);
  return switch (s) {
    AuthAutenticado(usuario: final u) => u,
    AuthRequiereCambioPassword(usuario: final u) => u,
    _ => null,
  };
});
