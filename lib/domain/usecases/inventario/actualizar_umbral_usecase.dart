import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/insumo.dart';
import '../../repositories/insumo_repository.dart';

/// HU-04.3 · Configura el umbral mínimo de stock de un insumo.
class ActualizarUmbralUseCase {
  final InsumoRepository _repo;
  const ActualizarUmbralUseCase(this._repo);

  Future<Either<Failure, Insumo>> call({
    required String insumoId,
    required double umbral,
  }) {
    if (umbral < 0) {
      return Future.value(const Left(ValidationFailure(S.umbralErrorValor)));
    }
    return _repo.actualizarUmbral(insumoId: insumoId, umbral: umbral);
  }
}
