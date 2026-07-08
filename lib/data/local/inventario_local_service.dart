import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import 'isar_service.dart';
import 'models/dosis_local.dart';
import 'models/movimiento_inventario_local.dart';

/// Aplica el descuento de insumos sobre la caché local de Isar (OM-02).
///
/// - **Online**: solo ajusta el stock local para reflejarlo de inmediato en la
///   UI (<1 s). El descuento autoritativo lo hace el trigger del servidor y
///   Realtime reconcilia el stock.
/// - **Offline**: ajusta el stock local Y registra los movimientos `descuento`
///   con `sincronizado = false`, que luego se reconcilian al sincronizar.
class InventarioLocalService {
  final IsarService _isar;
  static const _uuid = Uuid();

  InventarioLocalService(this._isar);

  Future<void> aplicarDescuento({
    required String programaId,
    required String usuarioId,
    String? cicloId,
    required bool offline,
    DateTime? momento,
  }) async {
    final ahora = momento ?? DateTime.now();
    final receta =
        await _isar.dosis.filter().programaIdEqualTo(programaId).findAll();
    if (receta.isEmpty) return;

    await _isar.isar.writeTxn(() async {
      for (final d in receta) {
        final insumo = await _isar.insumos.getByIndex('id', [d.insumoId]);
        if (insumo == null) continue;

        final nuevoStock =
            (insumo.stockActual - d.dosis).clamp(0, double.infinity).toDouble();
        insumo.stockActual = nuevoStock;
        await _isar.insumos.put(insumo);

        if (offline) {
          final mov = MovimientoInventarioLocal()
            ..id = _uuid.v4()
            ..insumoId = d.insumoId
            ..cicloId = cicloId
            ..usuarioId = usuarioId
            ..tipo = 'descuento'
            ..cantidad = d.dosis
            ..stockResultante = nuevoStock
            ..registradoEn = ahora
            ..sincronizado = false
            ..insumoNombre = d.insumoNombre;
          await _isar.movimientos.putByIndex('id', mov);
        }
      }
    });
  }
}
