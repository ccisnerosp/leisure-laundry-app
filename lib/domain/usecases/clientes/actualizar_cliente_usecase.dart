import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/cliente.dart';
import '../../repositories/cliente_repository.dart';

/// HU-05.1 · Edita los datos de un cliente existente.
class ActualizarClienteUseCase {
  final ClienteRepository _repo;
  const ActualizarClienteUseCase(this._repo);

  Future<Either<Failure, Cliente>> call(Cliente cliente) {
    if (cliente.nombre.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure(S.clienteErrorNombre)));
    }
    return _repo.actualizar(cliente);
  }
}
