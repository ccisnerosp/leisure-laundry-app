import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/cliente_repository.dart';

/// HU-05.1 · Activa o desactiva un cliente (sin eliminar su historial).
class CambiarEstadoClienteUseCase {
  final ClienteRepository _repo;
  const CambiarEstadoClienteUseCase(this._repo);

  Future<Either<Failure, void>> call(String id, {required bool activo}) =>
      _repo.cambiarEstado(id, activo: activo);
}
