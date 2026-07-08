import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/enums.dart';
import '../../entities/programa.dart';
import '../../repositories/programa_repository.dart';

/// HU-05.2 · Crea un programa de lavado o secado validando nombre y duración
/// (la duración respeta el CHECK del esquema: 1..240 minutos).
class CrearProgramaUseCase {
  final ProgramaRepository _repo;
  const CrearProgramaUseCase(this._repo);

  Future<Either<Failure, Programa>> call({
    required String nombre,
    required TipoPrograma tipo,
    required int duracionMinutos,
  }) {
    final n = nombre.trim();
    if (n.isEmpty) {
      return Future.value(const Left(ValidationFailure(S.programaErrorNombre)));
    }
    if (duracionMinutos < 1 || duracionMinutos > 240) {
      return Future.value(
          const Left(ValidationFailure(S.programaErrorDuracion)));
    }
    return _repo.crear(nombre: n, tipo: tipo, duracionMinutos: duracionMinutos);
  }
}
