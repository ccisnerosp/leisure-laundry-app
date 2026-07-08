import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/auth/cambiar_password_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/splash_screen.dart';
import '../../domain/entities/programa.dart';
import '../../presentation/screens/gerencial/clientes_screen.dart';
import '../../presentation/screens/gerencial/dashboard_screen.dart';
import '../../presentation/screens/gerencial/dosis_screen.dart';
import '../../presentation/screens/gerencial/inventario_screen.dart';
import '../../presentation/screens/gerencial/notificaciones_screen.dart';
import '../../presentation/screens/gerencial/programas_screen.dart';
import '../../presentation/screens/gerencial/usuarios_screen.dart';
import '../../presentation/screens/operario/iniciar_ciclo_screen.dart';
import '../../presentation/screens/operario/operario_home_screen.dart';
import 'rutas.dart';

/// Construye el router y centraliza la redirección por estado de sesión y rol
/// (HU-01.2: el operario nunca accede al módulo gerencial).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);

  return GoRouter(
    initialLocation: Rutas.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final loc = state.matchedLocation;

      switch (auth) {
        case AuthCargando():
          return loc == Rutas.splash ? null : Rutas.splash;

        case AuthNoAutenticado():
          return loc == Rutas.login ? null : Rutas.login;

        case AuthRequiereCambioPassword():
          return loc == Rutas.cambiarPassword ? null : Rutas.cambiarPassword;

        case AuthAutenticado(usuario: final u):
          // Rutas de "no sesión": saca al usuario a su home.
          final enPantallaAuth = loc == Rutas.login ||
              loc == Rutas.splash ||
              loc == Rutas.cambiarPassword;
          final home = u.esGerencial ? Rutas.gerencial : Rutas.operario;
          if (enPantallaAuth) return home;

          // El operario no puede entrar al módulo gerencial (HU-01.2).
          if (u.esOperario && loc.startsWith(Rutas.gerencial)) {
            return Rutas.operario;
          }
          return null;
      }
    },
    routes: [
      GoRoute(
        path: Rutas.splash,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: Rutas.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: Rutas.cambiarPassword,
        builder: (_, _) => const CambiarPasswordScreen(),
      ),
      GoRoute(
        path: Rutas.operario,
        builder: (_, _) => const OperarioHomeScreen(),
        routes: [
          GoRoute(
            path: 'iniciar',
            builder: (_, _) => const IniciarCicloScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Rutas.gerencial,
        builder: (_, _) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'programas',
            builder: (_, _) => const ProgramasScreen(),
          ),
          GoRoute(
            path: 'notificaciones',
            builder: (_, _) => const NotificacionesScreen(),
          ),
          GoRoute(
            path: 'usuarios',
            builder: (_, _) => const UsuariosScreen(),
          ),
          GoRoute(
            path: 'clientes',
            builder: (_, _) => const ClientesScreen(),
          ),
          GoRoute(
            path: 'inventario',
            builder: (_, _) => const InventarioScreen(),
          ),
          GoRoute(
            path: 'dosis',
            builder: (context, state) =>
                DosisScreen(programa: state.extra as Programa),
          ),
        ],
      ),
    ],
  );
});
