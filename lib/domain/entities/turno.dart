/// Turno operativo para agrupar ciclos en el dashboard (tabla `turnos`).
/// Las horas se representan como minutos desde medianoche para comparación.
class Turno {
  final String id;
  final String nombre;
  final int horaInicioMin; // minutos desde 00:00
  final int horaFinMin;
  final bool activo;

  const Turno({
    required this.id,
    required this.nombre,
    required this.horaInicioMin,
    required this.horaFinMin,
    this.activo = true,
  });

  /// Indica si [momento] cae dentro del rango horario del turno.
  bool contiene(DateTime momento) {
    final m = momento.hour * 60 + momento.minute;
    if (horaInicioMin <= horaFinMin) {
      return m >= horaInicioMin && m < horaFinMin;
    }
    // Turno que cruza medianoche.
    return m >= horaInicioMin || m < horaFinMin;
  }
}
