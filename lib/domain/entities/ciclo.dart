import 'enums.dart';

/// Ciclo de lavado o secado ejecutado (tabla `ciclos`). Es la entidad central
/// del OM-01. La duración del temporizador se calcula a partir de [inicioEn] y
/// la duración del programa, de modo que el conteo sea preciso incluso tras
/// reanudar la app (la app pudo estar en segundo plano).
class Ciclo {
  final String id;
  final String usuarioId;
  final String clienteId;
  final String programaId;
  final String? turnoId;
  final DateTime inicioEn;
  final DateTime? finEn;
  final EstadoCiclo estado;

  /// FALSE si fue creado offline y aún no se replicó (HU-02.5, Sprint 2).
  final bool sincronizado;

  // Datos desnormalizados para presentación (no se persisten en `ciclos`).
  final int duracionMinutos;
  final String? programaNombre;
  final String? clienteNombre;

  const Ciclo({
    required this.id,
    required this.usuarioId,
    required this.clienteId,
    required this.programaId,
    this.turnoId,
    required this.inicioEn,
    this.finEn,
    this.estado = EstadoCiclo.enCurso,
    this.sincronizado = true,
    this.duracionMinutos = 0,
    this.programaNombre,
    this.clienteNombre,
  });

  /// Momento exacto en que el temporizador debe llegar a cero.
  DateTime get finProgramado =>
      inicioEn.add(Duration(minutes: duracionMinutos));

  /// Tiempo restante respecto a [ahora]; nunca negativo.
  Duration tiempoRestante(DateTime ahora) {
    final restante = finProgramado.difference(ahora);
    return restante.isNegative ? Duration.zero : restante;
  }

  bool get estaEnCurso => estado == EstadoCiclo.enCurso;

  Ciclo copyWith({
    DateTime? finEn,
    EstadoCiclo? estado,
    bool? sincronizado,
  }) =>
      Ciclo(
        id: id,
        usuarioId: usuarioId,
        clienteId: clienteId,
        programaId: programaId,
        turnoId: turnoId,
        inicioEn: inicioEn,
        finEn: finEn ?? this.finEn,
        estado: estado ?? this.estado,
        sincronizado: sincronizado ?? this.sincronizado,
        duracionMinutos: duracionMinutos,
        programaNombre: programaNombre,
        clienteNombre: clienteNombre,
      );
}
