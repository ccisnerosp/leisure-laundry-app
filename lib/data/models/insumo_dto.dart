import '../../domain/entities/enums.dart';
import '../../domain/entities/insumo.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `insumos` y la entidad [Insumo].
class InsumoDto {
  static Insumo fromJson(Map<String, dynamic> j) => Insumo(
        id: j[ColInsumo.id] as String,
        nombre: j[ColInsumo.nombre] as String,
        unidad: UnidadInsumo.fromWire(j[ColInsumo.unidad] as String),
        stockActual: (j[ColInsumo.stockActual] as num).toDouble(),
        umbralMinimo: (j[ColInsumo.umbralMinimo] as num).toDouble(),
        activo: (j[ColInsumo.activo] as bool?) ?? true,
      );
}
