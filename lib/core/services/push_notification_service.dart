import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Handler de mensajes en segundo plano. Debe ser una función top-level
/// anotada con `@pragma('vm:entry-point')`. Cuando el mensaje trae payload de
/// `notification`, el SO muestra la notificación en la bandeja automáticamente
/// (HU-04.5), por lo que aquí no se requiere lógica adicional.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

/// Integra Firebase Cloud Messaging y los tres estados de recepción (HU-04.5):
/// primer plano (snackbar + navegación), segundo plano (bandeja del SO) y
/// app cerrada (al pulsar abre el dashboard).
class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Inicializa permisos, handlers y devuelve el token FCM (o null).
  Future<String?> inicializar({
    required void Function(RemoteMessage message) onPrimerPlano,
    required void Function() onAbrirDashboard,
  }) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Solicita permiso (Android 13+ / iOS) — HU-04.5.
    await _messaging.requestPermission();

    // App en primer plano.
    FirebaseMessaging.onMessage.listen(onPrimerPlano);

    // App en segundo plano y el usuario pulsa la notificación.
    FirebaseMessaging.onMessageOpenedApp.listen((_) => onAbrirDashboard());

    // App cerrada (terminada) y abierta desde la notificación.
    final inicial = await _messaging.getInitialMessage();
    if (inicial != null) onAbrirDashboard();

    try {
      return await _messaging.getToken();
    } catch (_) {
      return null;
    }
  }

  /// Plataforma reportada al backend para el token.
  String get plataforma => defaultTargetPlatform == TargetPlatform.iOS
      ? 'ios'
      : 'android';
}
