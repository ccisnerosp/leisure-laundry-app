import '../../domain/entities/ciclo.dart';
import '../../domain/entities/enums.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `ciclos` y la entidad [Ciclo].
///
/// Para presentación se hace un `select` con recursos embebidos del programa
/// (nombre, duración) y del cliente (nombre):
///   `*, programas(nombre,duracion_minutos), clientes(nombre)`
class CicloDto {
  /// Columnas embebidas que deben pedirse en el SELECT.
  static const select =
      '*, ${Tablas.programas}(${ColPrograma.nombre},${ColPrograma.duracionMinutos}), '
      '${Tablas.clientes}(${ColCliente.nombre})';

  static Ciclo fromJson(Map<String, dynamic> j) {
    final programa = j[Tablas.programas] as Map<String, dynamic>?;
    final cliente = j[Tablas.clientes] as Map<String, dynamic>?;
    return Ciclo(
      id: j[ColCiclo.id] as String,
      usuarioId: j[ColCiclo.usuarioId] as String,
      clienteId: j[ColCiclo.clienteId] as String,
      programaId: j[ColCiclo.programaId] as String,
      turnoId: j[ColCiclo.turnoId] as String?,
      inicioEn: DateTime.parse(j[ColCiclo.inicioEn] as String).toLocal(),
      finEn: j[ColCiclo.finEn] == null
          ? null
          : DateTime.parse(j[ColCiclo.finEn] as String).toLocal(),
      estado: EstadoCiclo.fromWire(j[ColCiclo.estado] as String),
      sincronizado: (j[ColCiclo.sincronizado] as bool?) ?? true,
      duracionMinutos:
          (programa?[ColPrograma.duracionMinutos] as num?)?.toInt() ?? 0,
      programaNombre: programa?[ColPrograma.nombre] as String?,
      clienteNombre: cliente?[ColCliente.nombre] as String?,
    );
  }

  static Map<String, dynamic> toInsert({
    required String usuarioId,
    required String clienteId,
    required String programaId,
    required String? turnoId,
    required DateTime inicioEn,
  }) =>
      {
        ColCiclo.usuarioId: usuarioId,
        ColCiclo.clienteId: clienteId,
        ColCiclo.programaId: programaId,
        if (turnoId != null) ColCiclo.turnoId: turnoId,
        ColCiclo.inicioEn: inicioEn.toUtc().toIso8601String(),
        ColCiclo.estado: EstadoCiclo.enCurso.wire,
      };
}
