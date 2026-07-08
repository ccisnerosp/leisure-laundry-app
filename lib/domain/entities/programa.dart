import 'enums.dart';

/// Programa de lavado o secado configurable (tabla `programas`).
/// La duración alimenta el temporizador del ciclo (OM-01).
class Programa {
  final String id;
  final String nombre;
  final TipoPrograma tipo;
  final int duracionMinutos;
  final bool activo;

  const Programa({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.duracionMinutos,
    this.activo = true,
  });

  Duration get duracion => Duration(minutes: duracionMinutos);

  Programa copyWith({
    String? nombre,
    TipoPrograma? tipo,
    int? duracionMinutos,
    bool? activo,
  }) =>
      Programa(
        id: id,
        nombre: nombre ?? this.nombre,
        tipo: tipo ?? this.tipo,
        duracionMinutos: duracionMinutos ?? this.duracionMinutos,
        activo: activo ?? this.activo,
      );
}
