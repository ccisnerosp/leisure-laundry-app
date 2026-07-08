import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/strings_es.dart';

/// Gestiona las notificaciones locales de fin de ciclo (OM-01, HU-02.3).
///
/// Programa una notificación para el instante exacto en que el temporizador
/// llega a cero, de modo que la alerta se dispare con sonido y vibración aunque
/// la app esté en segundo plano o la pantalla apagada (HU-02.2 / HU-02.3).
class NotificationService {
  NotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  static const _canalCiclos = 'canal_ciclos';

  /// Inicializa el plugin, las zonas horarias y el canal de notificaciones.
  static Future<NotificationService> inicializar() async {
    tzdata.initializeTimeZones();
    // Lima no aplica horario de verano; zona fija de la operación.
    tz.setLocalLocation(tz.getLocation('America/Lima'));

    final plugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await plugin.initialize(
      const InitializationSettings(android: android, iOS: darwin),
    );

    // Canal Android de alta importancia (sonido + vibración).
    const canal = AndroidNotificationChannel(
      _canalCiclos,
      S.notifCanalCiclosNombre,
      description: S.notifCanalCiclosDesc,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(canal);

    return NotificationService(plugin);
  }

  /// Solicita el permiso de notificaciones (Android 13+ / iOS) (HU-04.5).
  Future<void> solicitarPermisos() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  NotificationDetails get _detallesCiclo => const NotificationDetails(
        android: AndroidNotificationDetails(
          _canalCiclos,
          S.notifCanalCiclosNombre,
          channelDescription: S.notifCanalCiclosDesc,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          vibrationPattern: null,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      );

  /// Programa la notificación de fin de ciclo para [finProgramado].
  Future<void> programarFinCiclo({
    required int id,
    required String programa,
    required String cliente,
    required DateTime finProgramado,
  }) async {
    final cuando = tz.TZDateTime.from(finProgramado, tz.local);
    // Si el fin ya pasó, dispara de inmediato.
    if (cuando.isBefore(tz.TZDateTime.now(tz.local))) {
      await mostrarFinCicloAhora(
          id: id, programa: programa, cliente: cliente);
      return;
    }
    await _plugin.zonedSchedule(
      id,
      S.notifFinTitulo,
      S.notifFinCuerpo(programa, cliente),
      cuando,
      _detallesCiclo,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'ciclo:$id',
    );
  }

  /// Muestra la notificación de fin de ciclo inmediatamente.
  Future<void> mostrarFinCicloAhora({
    required int id,
    required String programa,
    required String cliente,
  }) async {
    await _plugin.show(
      id,
      S.notifFinTitulo,
      S.notifFinCuerpo(programa, cliente),
      _detallesCiclo,
      payload: 'ciclo:$id',
    );
  }

  /// Cancela la notificación programada (al cerrar el ciclo manualmente).
  Future<void> cancelar(int id) => _plugin.cancel(id);
}
