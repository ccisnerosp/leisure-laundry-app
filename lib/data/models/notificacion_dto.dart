import '../../domain/entities/notificacion_stock.dart';
import '../remote/supabase_types.dart';

/// Mapeo de `notificaciones_stock`. Embebe el insumo: `insumos(nombre)`.
class NotificacionDto {
  static const select = '*, ${Tablas.insumos}(${ColInsumo.nombre})';

  static NotificacionStock fromJson(Map<String, dynamic> j) {
    final insumo = j[Tablas.insumos] as Map<String, dynamic>?;
    return NotificacionStock(
      id: j[ColNotificacion.id] as String,
      insumoId: j[ColNotificacion.insumoId] as String,
      stockAlDisparar: (j[ColNotificacion.stockAlDisparar] as num).toDouble(),
      umbralAlDisparar: (j[ColNotificacion.umbralAlDisparar] as num).toDouble(),
      generadaEn:
          DateTime.parse(j[ColNotificacion.generadaEn] as String).toLocal(),
      atendida: (j[ColNotificacion.atendida] as bool?) ?? false,
      atendidaEn: j[ColNotificacion.atendidaEn] == null
          ? null
          : DateTime.parse(j[ColNotificacion.atendidaEn] as String).toLocal(),
      insumoNombre: insumo?[ColInsumo.nombre] as String?,
    );
  }
}
