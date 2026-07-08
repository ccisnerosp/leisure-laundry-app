import 'package:isar/isar.dart';

part 'insumo_local.g.dart';

/// Caché local (Isar) del catálogo de insumos para mostrar y descontar stock
/// sin conexión (HU-03.5). Se mantiene sincronizada con Supabase vía Realtime
/// (canal public:insumos) cuando hay conexión.
@collection
class InsumoLocal {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  late String nombre;

  /// Valor `wire` del enum `unidad_insumo` ('ml' | 'g' | 'unidad').
  late String unidad;

  late double stockActual;
  late double umbralMinimo;
  late bool activo;

  InsumoLocal();
}
