import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_types.dart';

/// Suscribe el dashboard gerencial a los canales Realtime de Supabase
/// (HU-04.1): `public:ciclos`, `public:insumos` y `public:notificaciones_stock`.
/// Invoca los callbacks cuando llega un cambio para refrescar la UI.
class DashboardRealtimeService {
  final SupabaseClient _supabase;
  final List<RealtimeChannel> _canales = [];

  DashboardRealtimeService(this._supabase);

  void iniciar({
    required void Function() onCiclos,
    required void Function() onInsumos,
    required void Function() onNotificaciones,
  }) {
    detener();
    _canales.add(_suscribir('public:ciclos', Tablas.ciclos, onCiclos));
    _canales.add(_suscribir('public:insumos', Tablas.insumos, onInsumos));
    _canales.add(_suscribir(
        'public:notificaciones_stock', Tablas.notificacionesStock,
        onNotificaciones));
  }

  RealtimeChannel _suscribir(
      String nombre, String tabla, void Function() onCambio) {
    return _supabase
        .channel(nombre)
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: tabla,
          callback: (_) => onCambio(),
        )
        .subscribe();
  }

  void detener() {
    for (final c in _canales) {
      c.unsubscribe();
    }
    _canales.clear();
  }
}
