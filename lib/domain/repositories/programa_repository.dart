import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/enums.dart';
import '../entities/programa.dart';

/// Contrato de gestión de programas de lavado/secado (HU-05.2).
abstract interface class ProgramaRepository {
  /// Lista programas. Si [soloActivos] es true devuelve únicamente los activos
  /// (usado por el operario al iniciar un ciclo).
  Future<Either<Failure, List<Programa>>> listar({bool soloActivos = false});

  Future<Either<Failure, Programa>> crear({
    required String nombre,
    required TipoPrograma tipo,
    required int duracionMinutos,
  });

  Future<Either<Failure, Programa>> actualizar(Programa programa);

  /// Activa o desactiva un programa (no se elimina, conserva historial).
  Future<Either<Failure, void>> cambiarEstado(String id, {required bool activo});
}
