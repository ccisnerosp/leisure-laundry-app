import '../../domain/entities/ciclo.dart';
import '../../domain/entities/enums.dart';
import 'models/ciclo_local.dart';

/// Conversión entre la entidad de dominio [Ciclo] y el modelo Isar [CicloLocal].
abstract class CicloLocalMapper {
  static CicloLocal fromEntity(Ciclo c) => CicloLocal()
    ..id = c.id
    ..usuarioId = c.usuarioId
    ..clienteId = c.clienteId
    ..programaId = c.programaId
    ..turnoId = c.turnoId
    ..inicioEn = c.inicioEn
    ..finEn = c.finEn
    ..estado = c.estado.wire
    ..sincronizado = c.sincronizado
    ..duracionMinutos = c.duracionMinutos
    ..programaNombre = c.programaNombre
    ..clienteNombre = c.clienteNombre;

  static Ciclo toEntity(CicloLocal l) => Ciclo(
        id: l.id,
        usuarioId: l.usuarioId,
        clienteId: l.clienteId,
        programaId: l.programaId,
        turnoId: l.turnoId,
        inicioEn: l.inicioEn,
        finEn: l.finEn,
        estado: EstadoCiclo.fromWire(l.estado),
        sincronizado: l.sincronizado,
        duracionMinutos: l.duracionMinutos,
        programaNombre: l.programaNombre,
        clienteNombre: l.clienteNombre,
      );
}
