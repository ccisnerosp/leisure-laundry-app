import 'enums.dart';

/// Movimiento de inventario (tabla `movimientos_inventario`). Registra
/// descuentos automáticos por ciclo, ingresos y ajustes (OM-02, HU-03.4).
class MovimientoInventario {
  final String id;
  final String insumoId;
  final String? cicloId;
  final String usuarioId;
  final TipoMovimiento tipo;
  final double cantidad;
  final double stockResultante;
  final DateTime registradoEn;
  final bool sincronizado;

  // Desnormalizado para presentación del historial.
  final String? insumoNombre;
  final String? usuarioNombre;

  const MovimientoInventario({
    required this.id,
    required this.insumoId,
    this.cicloId,
    required this.usuarioId,
    required this.tipo,
    required this.cantidad,
    required this.stockResultante,
    required this.registradoEn,
    this.sincronizado = true,
    this.insumoNombre,
    this.usuarioNombre,
  });
}
