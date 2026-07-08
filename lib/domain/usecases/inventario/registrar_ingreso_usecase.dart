import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/insumo.dart';
import '../../repositories/insumo_repository.dart';

/// HU-03.3 · Registra el ingreso (reabastecimiento) de un insumo.
class RegistrarIngresoUseCase {
  final InsumoRepository _repo;
  const RegistrarIngresoUseCase(this._repo);

  Future<Either<Failure, Insumo>> call({
    required String insumoId,
    required double cantidad,
    required String usuarioId,
  }) {
    if (cantidad <= 0) {
      return Future.value(const Left(ValidationFailure(S.ingresoErrorCantidad)));
    }
    return _repo.registrarIngreso(
      insumoId: insumoId,
      cantidad: cantidad,
      usuarioId: usuarioId,
    );
  }
}
