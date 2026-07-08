import 'enums.dart';

/// Insumo del inventario virtual (tabla `insumos`, OM-02).
class Insumo {
  final String id;
  final String nombre;
  final UnidadInsumo unidad;
  final double stockActual;
  final double umbralMinimo;
  final bool activo;

  const Insumo({
    required this.id,
    required this.nombre,
    required this.unidad,
    required this.stockActual,
    required this.umbralMinimo,
    this.activo = true,
  });

  /// Clasificación visual del stock (alineada con la vista v_estado_inventario).
  /// Se usa a fondo en el dashboard del Sprint 3, pero el cálculo vive aquí.
  EstadoStock get estadoStock {
    if (stockActual <= umbralMinimo) return EstadoStock.critico;
    if (stockActual <= umbralMinimo * 1.5) return EstadoStock.bajo;
    return EstadoStock.normal;
  }

  Insumo copyWith({double? stockActual, double? umbralMinimo, bool? activo}) =>
      Insumo(
        id: id,
        nombre: nombre,
        unidad: unidad,
        stockActual: stockActual ?? this.stockActual,
        umbralMinimo: umbralMinimo ?? this.umbralMinimo,
        activo: activo ?? this.activo,
      );
}

enum EstadoStock { normal, bajo, critico }
