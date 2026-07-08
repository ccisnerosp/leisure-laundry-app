import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/cliente.dart';
import '../../repositories/cliente_repository.dart';

/// HU-02.1 · Lista clientes activos para vincularlos a un ciclo.
class ListarClientesUseCase {
  final ClienteRepository _repo;
  const ListarClientesUseCase(this._repo);

  Future<Either<Failure, List<Cliente>>> call({bool soloActivos = true}) =>
      _repo.listar(soloActivos: soloActivos);
}
