import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/programa_repository.dart';

/// HU-05.2 · Activa o desactiva un programa (sin eliminarlo).
class CambiarEstadoProgramaUseCase {
  final ProgramaRepository _repo;
  const CambiarEstadoProgramaUseCase(this._repo);

  Future<Either<Failure, void>> call(String id, {required bool activo}) =>
      _repo.cambiarEstado(id, activo: activo);
}
