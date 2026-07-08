import 'package:isar/isar.dart';

part 'dosis_local.g.dart';

/// Caché local (Isar) de la receta `programa_insumo`. Necesaria para que el
/// descuento de insumos funcione SIN conexión (HU-03.5): al iniciar un ciclo
/// offline, la app necesita conocer la dosis de cada insumo por programa.
@collection
class DosisLocal {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String programaId;

  late String insumoId;
  late double dosis;

  String? insumoNombre;
  String? insumoUnidad;

  DosisLocal();
}
