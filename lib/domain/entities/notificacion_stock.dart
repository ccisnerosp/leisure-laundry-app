/// Notificación de stock crítico (tabla `notificaciones_stock`, OM-03).
class NotificacionStock {
  final String id;
  final String insumoId;
  final double stockAlDisparar;
  final double umbralAlDisparar;
  final DateTime generadaEn;
  final bool atendida;
  final DateTime? atendidaEn;

  // Desnormalizado para presentación.
  final String? insumoNombre;

  const NotificacionStock({
    required this.id,
    required this.insumoId,
    required this.stockAlDisparar,
    required this.umbralAlDisparar,
    required this.generadaEn,
    required this.atendida,
    this.atendidaEn,
    this.insumoNombre,
  });
}
