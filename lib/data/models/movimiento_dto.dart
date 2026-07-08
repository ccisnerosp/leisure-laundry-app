import '../../domain/entities/enums.dart';
import '../../domain/entities/movimiento_inventario.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre `movimientos_inventario` y la entidad [MovimientoInventario].
///
/// El SELECT embebe el insumo (`insumos(nombre)`) y el turno del ciclo
/// (`ciclos(turno_id)`) para poder filtrar el historial por turno (HU-03.4).
class MovimientoDto {
  static const select =
      '*, ${Tablas.insumos}(${ColInsumo.nombre}), ${Tablas.usuarios}(${ColUsuario.nombre}), ${Tablas.ciclos}(${ColCiclo.turnoId})';

  static MovimientoInventario fromJson(Map<String, dynamic> j) {
    final insumo = j[Tablas.insumos] as Map<String, dynamic>?;
    final usuario = j[Tablas.usuarios] as Map<String, dynamic>?;
    return MovimientoInventario(
      id: j[ColMovimiento.id] as String,
      insumoId: j[ColMovimiento.insumoId] as String,
      cicloId: j[ColMovimiento.cicloId] as String?,
      usuarioId: j[ColMovimiento.usuarioId] as String,
      tipo: TipoMovimiento.fromWire(j[ColMovimiento.tipo] as String),
      cantidad: (j[ColMovimiento.cantidad] as num).toDouble(),
      stockResultante: (j[ColMovimiento.stockResultante] as num).toDouble(),
      registradoEn:
          DateTime.parse(j[ColMovimiento.registradoEn] as String).toLocal(),
      sincronizado: (j[ColMovimiento.sincronizado] as bool?) ?? true,
      insumoNombre: insumo?[ColInsumo.nombre] as String?,
      usuarioNombre: usuario?[ColUsuario.nombre] as String?,
    );
  }

  /// turno_id embebido del ciclo asociado (para filtro por turno).
  static String? turnoIdDe(Map<String, dynamic> j) {
    final ciclo = j[Tablas.ciclos] as Map<String, dynamic>?;
    return ciclo?[ColCiclo.turnoId] as String?;
  }
}
