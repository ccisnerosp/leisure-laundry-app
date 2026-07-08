import 'package:isar/isar.dart';

part 'ciclo_local.g.dart';

/// Espejo local (Isar) de la tabla `ciclos` para el modo offline (HU-02.5).
///
/// En Sprint 1 se crea el modelo y se persiste el ciclo localmente como caché;
/// la sincronización bidireccional completa se implementa en Sprint 2.
@collection
class CicloLocal {
  /// Clave interna autoincremental de Isar.
  Id isarId = Isar.autoIncrement;

  /// UUID del ciclo (coincide con `ciclos.id` en Supabase). Único.
  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String usuarioId;

  late String clienteId;
  late String programaId;
  String? turnoId;

  late DateTime inicioEn;
  DateTime? finEn;

  /// Valor `wire` del enum `estado_ciclo` ('en_curso' | 'completado' | 'cancelado').
  @Index()
  late String estado;

  /// FALSE si fue creado/cerrado offline y aún no se replicó al servidor.
  @Index()
  late bool sincronizado;

  // Datos desnormalizados para mostrar el historial sin red.
  int duracionMinutos = 0;
  String? programaNombre;
  String? clienteNombre;

  CicloLocal();
}
