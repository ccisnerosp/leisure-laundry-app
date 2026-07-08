import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/ciclo_local.dart';
import 'models/dosis_local.dart';
import 'models/insumo_local.dart';
import 'models/movimiento_inventario_local.dart';

/// Inicializa y expone la instancia única de Isar (base de datos local offline).
class IsarService {
  IsarService(this.isar);

  final Isar isar;

  /// Abre la base de datos local con los esquemas registrados.
  static Future<IsarService> abrir() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        CicloLocalSchema,
        InsumoLocalSchema,
        MovimientoInventarioLocalSchema,
        DosisLocalSchema,
      ],
      directory: dir.path,
      name: 'leisure',
    );
    return IsarService(isar);
  }

  IsarCollection<CicloLocal> get ciclos => isar.cicloLocals;
  IsarCollection<InsumoLocal> get insumos => isar.insumoLocals;
  IsarCollection<MovimientoInventarioLocal> get movimientos =>
      isar.movimientoInventarioLocals;
  IsarCollection<DosisLocal> get dosis => isar.dosisLocals;
}
