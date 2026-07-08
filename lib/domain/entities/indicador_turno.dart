/// Indicadores agregados del turno en curso (vista `v_dashboard_turno`, HU-04.2).
class IndicadorTurno {
  final String turnoId;
  final String turnoNombre;
  final int ciclosEnCurso;
  final int ciclosCompletados;
  final double? minutosPromedio;

  const IndicadorTurno({
    required this.turnoId,
    required this.turnoNombre,
    required this.ciclosEnCurso,
    required this.ciclosCompletados,
    this.minutosPromedio,
  });
}
