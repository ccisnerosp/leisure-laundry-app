import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/services/alarma_service.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/push_notification_service.dart';
import '../../data/local/inventario_local_service.dart';
import '../../data/local/isar_service.dart';
import '../../data/remote/catalogo_cache_service.dart';
import '../../data/remote/dashboard_realtime_service.dart';

/// Cliente de Supabase ya inicializado en `main()`.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Servicio Isar (base local offline). Se sobreescribe en `main()` con la
/// instancia abierta mediante `ProviderScope(overrides: [...])`.
final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError(
      'isarServiceProvider debe sobreescribirse en main() con la instancia abierta.');
});

/// Servicio de notificaciones locales. Se sobreescribe en `main()` con la
/// instancia ya inicializada.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError(
      'notificationServiceProvider debe sobreescribirse en main().');
});

/// Servicio de alarma sonora en primer plano.
final alarmaServiceProvider = Provider<AlarmaService>((ref) {
  final servicio = AlarmaService();
  ref.onDispose(servicio.dispose);
  return servicio;
});

/// Detección de conectividad (Sprint 2).
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

/// Aplica descuentos de inventario sobre la caché local (Sprint 2).
final inventarioLocalServiceProvider = Provider<InventarioLocalService>((ref) {
  return InventarioLocalService(ref.watch(isarServiceProvider));
});

/// Caché de catálogo (insumos/dosis) + Realtime de stock (Sprint 2).
final catalogoCacheServiceProvider = Provider<CatalogoCacheService>((ref) {
  return CatalogoCacheService(
    ref.watch(supabaseClientProvider),
    ref.watch(isarServiceProvider),
  );
});

/// Indica si Firebase se inicializó correctamente (existe `google-services.json`).
/// Se sobreescribe en `main()`. Si es false, el push se desactiva sin romper la app.
final firebaseDisponibleProvider = Provider<bool>((ref) => false);

/// Servicio de notificaciones push FCM (Sprint 3).
final pushNotificationServiceProvider = Provider<PushNotificationService>((ref) {
  return PushNotificationService();
});

/// Servicio Realtime del dashboard gerencial (Sprint 3).
final dashboardRealtimeServiceProvider =
    Provider<DashboardRealtimeService>((ref) {
  final servicio = DashboardRealtimeService(ref.watch(supabaseClientProvider));
  ref.onDispose(servicio.detener);
  return servicio;
});
