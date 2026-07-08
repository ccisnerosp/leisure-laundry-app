import '../../domain/entities/enums.dart';
import '../../domain/entities/programa.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `programas` y la entidad [Programa].
class ProgramaDto {
  static Programa fromJson(Map<String, dynamic> j) => Programa(
        id: j[ColPrograma.id] as String,
        nombre: j[ColPrograma.nombre] as String,
        tipo: TipoPrograma.fromWire(j[ColPrograma.tipo] as String),
        duracionMinutos: (j[ColPrograma.duracionMinutos] as num).toInt(),
        activo: (j[ColPrograma.activo] as bool?) ?? true,
      );

  static Map<String, dynamic> toInsert({
    required String nombre,
    required TipoPrograma tipo,
    required int duracionMinutos,
  }) =>
      {
        ColPrograma.nombre: nombre,
        ColPrograma.tipo: tipo.wire,
        ColPrograma.duracionMinutos: duracionMinutos,
      };

  static Map<String, dynamic> toUpdate(Programa p) => {
        ColPrograma.nombre: p.nombre,
        ColPrograma.tipo: p.tipo.wire,
        ColPrograma.duracionMinutos: p.duracionMinutos,
        ColPrograma.activo: p.activo,
      };
}
