/// Fila de la vista `v_estado_inventario` con la clasificación de stock (HU-04.1).
class EstadoInventarioItem {
  final String id;
  final String nombre;
  final String unidad;
  final double stockActual;
  final double umbralMinimo;

  /// 'normal' | 'bajo' | 'critico' (calculado por la vista).
  final String estadoStock;

  const EstadoInventarioItem({
    required this.id,
    required this.nombre,
    required this.unidad,
    required this.stockActual,
    required this.umbralMinimo,
    required this.estadoStock,
  });
}
