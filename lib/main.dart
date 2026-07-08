import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/l10n/strings_es.dart';
import 'core/router/app_router.dart';
import 'core/router/rutas.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'data/local/isar_service.dart';
import 'data/remote/secure_local_storage.dart';
import 'domain/entities/usuario.dart';
import 'env/env.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/core_providers.dart';
import 'presentation/providers/sync_providers.dart';
import 'presentation/providers/usecase_providers.dart';

/// Llave global para mostrar SnackBars desde fuera del árbol (push en primer
/// plano, HU-04.5).
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase (FCM). Si no hay `google-services.json`, falla de forma controlada
  // y la app sigue funcionando sin push (Sprint 3).
  var firebaseOk = false;
  try {
    await Firebase.initializeApp();
    firebaseOk = true;
  } catch (_) {
    firebaseOk = false;
  }

  // Supabase Auth con sesión persistida en almacenamiento seguro (HU-01.3).
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(
      localStorage: SecureLocalStorage(),
      autoRefreshToken: true,
    ),
  );

  // Base local offline (Isar) y notificaciones locales.
  final isarService = await IsarService.abrir();
  final notificationService = await NotificationService.inicializar();

  runApp(
    ProviderScope(
      overrides: [
        isarServiceProvider.overrideWithValue(isarService),
        notificationServiceProvider.overrideWithValue(notificationService),
        firebaseDisponibleProvider.overrideWithValue(firebaseOk),
      ],
      child: const LeisureApp(),
    ),
  );
}

class LeisureApp extends ConsumerStatefulWidget {
  const LeisureApp({super.key});

  @override
  ConsumerState<LeisureApp> createState() => _LeisureAppState();
}

class _LeisureAppState extends ConsumerState<LeisureApp> {
  bool _pushIniciado = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Restaura la sesión persistida y solicita permiso de notificaciones.
      await ref.read(authControllerProvider.notifier).cargarSesion();
      await ref.read(notificationServiceProvider).solicitarPermisos();
      // Arranca la detección de conectividad y la sincronización offline.
      ref.read(syncControllerProvider);
    });
  }

  /// Inicializa el push FCM una vez, para el perfil gerencial (HU-04.5).
  Future<void> _inicializarPush(Usuario usuario) async {
    if (_pushIniciado ||
        !usuario.esGerencial ||
        !ref.read(firebaseDisponibleProvider)) {
      return;
    }
    _pushIniciado = true;
    final push = ref.read(pushNotificationServiceProvider);
    final token = await push.inicializar(
      onPrimerPlano: (mensaje) {
        final n = mensaje.notification;
        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(n?.title ?? S.notifStockTitulo),
          action: SnackBarAction(
            label: 'Ver',
            onPressed: () => ref.read(routerProvider).go(Rutas.gerencial),
          ),
        ));
      },
      onAbrirDashboard: () => ref.read(routerProvider).go(Rutas.gerencial),
    );
    if (token != null) {
      await ref.read(registrarTokenUseCaseProvider).call(
            usuarioId: usuario.id,
            token: token,
            plataforma: push.plataforma,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inicializa el push cuando un usuario gerencial queda autenticado.
    ref.listen(usuarioActualProvider, (_, usuario) {
      if (usuario != null) _inicializarPush(usuario);
    });

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: S.appNombre,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // soporte modo oscuro del SO (HU-06.2)
      routerConfig: router,
    );
  }
}
