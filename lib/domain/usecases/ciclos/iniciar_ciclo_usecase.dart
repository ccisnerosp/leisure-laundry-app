import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/ciclo.dart';
import '../../entities/cliente.dart';
import '../../entities/programa.dart';
import '../../entities/turno.dart';
import '../../repositories/ciclo_repository.dart';
import '../../repositories/turno_repository.dart';

/// HU-02.2 + HU-03.1 · Inicia un ciclo. Resuelve el turno activo según la hora
/// actual y delega la persistencia al repositorio. El descuento de insumos lo
/// ejecuta el trigger del servidor al insertar el ciclo (no se duplica aquí).
class IniciarCicloUseCase {
  final CicloRepository _cicloRepo;
  final TurnoRepository _turnoRepo;
  const IniciarCicloUseCase(this._cicloRepo, this._turnoRepo);

  Future<Either<Failure, Ciclo>> call({
    required String usuarioId,
    required Programa programa,
    required Cliente cliente,
    DateTime? ahora,
  }) async {
    if (!programa.activo) {
      return const Left(ValidationFailure(S.cicloSinProgramas));
    }
    if (!cliente.activo) {
      return const Left(ValidationFailure(S.cicloSinClientes));
    }

    // Resuelve el turno que contiene el momento de inicio (puede no haber).
    final momento = ahora ?? DateTime.now();
    String? turnoId;
    final turnosRes = await _turnoRepo.listarActivos();
    turnosRes.fold(
      (_) => turnoId = null, // si falla, el ciclo igual se crea sin turno
      (turnos) => turnoId = _turnoActivo(turnos, momento)?.id,
    );

    return _cicloRepo.iniciar(
      usuarioId: usuarioId,
      clienteId: cliente.id,
      programaId: programa.id,
      turnoId: turnoId,
      duracionMinutos: programa.duracionMinutos,
      programaNombre: programa.nombre,
      clienteNombre: cliente.nombre,
    );
  }

  Turno? _turnoActivo(List<Turno> turnos, DateTime momento) {
    for (final t in turnos) {
      if (t.contiene(momento)) return t;
    }
    return null;
  }
}
