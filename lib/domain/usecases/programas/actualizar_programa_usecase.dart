import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/programa.dart';
import '../../repositories/programa_repository.dart';

/// HU-05.2 · Edita un programa existente.
class ActualizarProgramaUseCase {
  final ProgramaRepository _repo;
  const ActualizarProgramaUseCase(this._repo);

  Future<Either<Failure, Programa>> call(Programa programa) {
    if (programa.nombre.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure(S.programaErrorNombre)));
    }
    if (programa.duracionMinutos < 1 || programa.duracionMinutos > 240) {
      return Future.value(
          const Left(ValidationFailure(S.programaErrorDuracion)));
    }
    return _repo.actualizar(programa);
  }
}
