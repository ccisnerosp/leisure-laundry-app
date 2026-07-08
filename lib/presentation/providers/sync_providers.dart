import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core_providers.dart';
import 'usecase_providers.dart';

/// Estado de conectividad y sincronización (HU-02.5 / HU-03.5).
class SyncEstado {
  final bool online;
  final bool sincronizando;
  final int pendientes;
  final String? mensaje;

  const SyncEstado({
    this.online = true,
    this.sincronizando = false,
    this.pendientes = 0,
    this.mensaje,
  });

  SyncEstado copyWith({
    bool? online,
    bool? sincronizando,
    int? pendientes,
    String? mensaje,
  }) =>
      SyncEstado(
        online: online ?? this.online,
        sincronizando: sincronizando ?? this.sincronizando,
        pendientes: pendientes ?? this.pendientes,
        mensaje: mensaje,
      );
}

class SyncController extends StateNotifier<SyncEstado> {
  final Ref _ref;
  StreamSubscription<bool>? _sub;

  SyncController(this._ref) : super(const SyncEstado()) {
    _init();
  }

  Future<void> _init() async {
    final connectivity = _ref.read(connectivityServiceProvider);
    final online = await connectivity.estaEnLinea();
    state = state.copyWith(online: online);
    if (online) await _alConectar();
    _sub = connectivity.cambios.listen(_onCambio);
    await refrescarPendientes();
  }

  void _onCambio(bool online) {
    if (online && !state.online) {
      state = state.copyWith(online: true);
      _alConectar();
    } else if (!online && state.online) {
      _ref.read(catalogoCacheServiceProvider).detenerRealtime();
      state = state.copyWith(online: false);
    }
  }

  /// Al recuperar conexión: cachea catálogo, activa Realtime y sincroniza.
  Future<void> _alConectar() async {
    final cache = _ref.read(catalogoCacheServiceProvider);
    try {
      await cache.prefetch();
      cache.iniciarRealtimeStock();
    } catch (_) {
      // Sin catálogo cacheado el descuento offline puede no aplicar; se
      // reintenta en la próxima reconexión.
    }
    await sincronizarAhora();
  }

  /// Sincroniza los registros locales pendientes con Supabase.
  Future<void> sincronizarAhora() async {
    if (state.sincronizando) return;
    state = state.copyWith(sincronizando: true);
    final res = await _ref.read(sincronizarUseCaseProvider).call();
    final pendientes = await _ref.read(sincronizarUseCaseProvider).pendientes();
    state = res.fold(
      (f) => state.copyWith(
          sincronizando: false, pendientes: pendientes, mensaje: f.mensaje),
      (r) => state.copyWith(
          sincronizando: false, pendientes: pendientes, mensaje: null),
    );
  }

  Future<void> refrescarPendientes() async {
    final pendientes = await _ref.read(sincronizarUseCaseProvider).pendientes();
    state = state.copyWith(pendientes: pendientes);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final syncControllerProvider =
    StateNotifierProvider<SyncController, SyncEstado>((ref) {
  return SyncController(ref);
});

/// Atajo: ¿hay conexión?
final estaEnLineaProvider =
    Provider<bool>((ref) => ref.watch(syncControllerProvider).online);
