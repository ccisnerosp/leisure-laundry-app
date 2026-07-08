import '../../domain/entities/turno.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `turnos` y la entidad [Turno]. Las columnas TIME
/// llegan como texto "HH:MM:SS"; se convierten a minutos desde medianoche.
class TurnoDto {
  static Turno fromJson(Map<String, dynamic> j) => Turno(
        id: j[ColTurno.id] as String,
        nombre: j[ColTurno.nombre] as String,
        horaInicioMin: _toMinutos(j[ColTurno.horaInicio] as String),
        horaFinMin: _toMinutos(j[ColTurno.horaFin] as String),
        activo: (j[ColTurno.activo] as bool?) ?? true,
      );

  static int _toMinutos(String hhmmss) {
    final partes = hhmmss.split(':');
    final h = int.parse(partes[0]);
    final m = partes.length > 1 ? int.parse(partes[1]) : 0;
    return h * 60 + m;
  }
}
