import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/ciclo.dart';

/// Contrato de gestión de ciclos (OM-01). El descuento de insumos lo ejecuta el
/// trigger del servidor (`fn_descontar_insumos_por_ciclo`) al insertar el
/// ciclo, por lo que el repositorio NO lo replica en Sprint 1.
abstract interface class CicloRepository {
  /// Inicia un ciclo: persiste el registro con estado `en_curso` y devuelve el
  /// ciclo creado (con su id y hora de inicio reales).
  Future<Either<Failure, Ciclo>> iniciar({
    required String usuarioId,
    required String clienteId,
    required String programaId,
    required String? turnoId,
    required int duracionMinutos,
    String? programaNombre,
    String? clienteNombre,
  });

  /// Cierra un ciclo registrando la hora de fin y estado `completado`
  /// (HU-02.4).
  Future<Either<Failure, Ciclo>> cerrar(String cicloId);

  /// Lista los ciclos del [usuarioId] dado, más recientes primero.
  Future<Either<Failure, List<Ciclo>>> listarPorUsuario(String usuarioId);

  /// Devuelve el ciclo en curso del usuario, si existe (para reanudar el
  /// temporizador tras reabrir la app).
  Future<Either<Failure, Ciclo?>> cicloEnCurso(String usuarioId);
}
