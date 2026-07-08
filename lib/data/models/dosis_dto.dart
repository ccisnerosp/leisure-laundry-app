import '../../domain/entities/dosis_programa.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre `programa_insumo` y la entidad [DosisPrograma].
///
/// El SELECT embebe el insumo: `*, insumos(nombre,unidad)`.
class DosisDto {
  static const select =
      '*, ${Tablas.insumos}(${ColInsumo.nombre},${ColInsumo.unidad})';

  static DosisPrograma fromJson(Map<String, dynamic> j) {
    final insumo = j[Tablas.insumos] as Map<String, dynamic>?;
    return DosisPrograma(
      id: j[ColProgramaInsumo.id] as String,
      programaId: j[ColProgramaInsumo.programaId] as String,
      insumoId: j[ColProgramaInsumo.insumoId] as String,
      dosis: (j[ColProgramaInsumo.dosis] as num).toDouble(),
      insumoNombre: insumo?[ColInsumo.nombre] as String?,
      insumoUnidad: insumo?[ColInsumo.unidad] as String?,
    );
  }
}
