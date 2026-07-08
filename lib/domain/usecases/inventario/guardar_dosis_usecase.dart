import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/dosis_programa.dart';
import '../../repositories/dosis_repository.dart';

/// HU-03.2 · Configura (crea/actualiza) la dosis de un insumo por programa.
class GuardarDosisUseCase {
  final DosisRepository _repo;
  const GuardarDosisUseCase(this._repo);

  Future<Either<Failure, DosisPrograma>> call({
    required String programaId,
    required String insumoId,
    required double dosis,
  }) {
    if (dosis <= 0) {
      return Future.value(const Left(ValidationFailure(S.dosisErrorValor)));
    }
    return _repo.guardar(
        programaId: programaId, insumoId: insumoId, dosis: dosis);
  }
}
