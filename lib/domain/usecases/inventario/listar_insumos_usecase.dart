import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/insumo.dart';
import '../../repositories/insumo_repository.dart';

/// HU-03.3 · Lista los insumos del inventario.
class ListarInsumosUseCase {
  final InsumoRepository _repo;
  const ListarInsumosUseCase(this._repo);

  Future<Either<Failure, List<Insumo>>> call({bool soloActivos = true}) =>
      _repo.listar(soloActivos: soloActivos);
}
