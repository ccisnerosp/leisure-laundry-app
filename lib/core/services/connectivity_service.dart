import 'package:connectivity_plus/connectivity_plus.dart';

/// Detecta el estado de conectividad del dispositivo (HU-02.5 / HU-03.5).
class ConnectivityService {
  final Connectivity _connectivity;
  ConnectivityService([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  static bool _hayRed(List<ConnectivityResult> r) =>
      r.any((e) => e != ConnectivityResult.none);

  /// Estado actual: `true` si hay alguna interfaz de red activa.
  Future<bool> estaEnLinea() async {
    final r = await _connectivity.checkConnectivity();
    return _hayRed(r);
  }

  /// Stream de cambios de conectividad como booleano (online/offline).
  Stream<bool> get cambios =>
      _connectivity.onConnectivityChanged.map(_hayRed);
}
