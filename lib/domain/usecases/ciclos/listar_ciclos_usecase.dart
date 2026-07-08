import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/ciclo.dart';
import '../../repositories/ciclo_repository.dart';

/// HU-02.4 · Lista el historial de ciclos del operario.
class ListarCiclosUseCase {
  final CicloRepository _repo;
  const ListarCiclosUseCase(this._repo);

  Future<Either<Failure, List<Ciclo>>> call(String usuarioId) =>
      _repo.listarPorUsuario(usuarioId);
}
