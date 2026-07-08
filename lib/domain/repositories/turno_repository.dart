import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/turno.dart';

/// Contrato de turnos. Se usa para asignar el turno correcto al crear un ciclo.
abstract interface class TurnoRepository {
  Future<Either<Failure, List<Turno>>> listarActivos();
}
