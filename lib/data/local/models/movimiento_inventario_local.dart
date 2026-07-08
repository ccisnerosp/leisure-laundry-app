import 'package:isar/isar.dart';

part 'movimiento_inventario_local.g.dart';

/// Espejo local (Isar) de `movimientos_inventario` para el descuento de insumos
/// offline (HU-03.5). Los movimientos de tipo `descuento` creados offline se
/// reconcilian con los que genera el trigger del servidor al sincronizar el
/// ciclo (no se reenvían para evitar doble descuento).
@collection
class MovimientoInventarioLocal {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String insumoId;

  String? cicloId;
  late String usuarioId;

  /// Valor `wire` del enum `tipo_movimiento` ('descuento' | 'ingreso' | 'ajuste').
  late String tipo;

  late double cantidad;
  late double stockResultante;
  late DateTime registradoEn;

  @Index()
  late bool sincronizado;

  String? insumoNombre;

  MovimientoInventarioLocal();
}
