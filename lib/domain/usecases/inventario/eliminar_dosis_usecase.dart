import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/dosis_repository.dart';

/// HU-03.2 · Elimina la dosis de un insumo de un programa.
class EliminarDosisUseCase {
  final DosisRepository _repo;
  const EliminarDosisUseCase(this._repo);

  Future<Either<Failure, void>> call(String dosisId) => _repo.eliminar(dosisId);
}
