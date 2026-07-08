import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/usuario_repository.dart';

/// HU-05.3 · Activa o desactiva un usuario sin eliminar su historial.
class CambiarEstadoUsuarioUseCase {
  final UsuarioRepository _repo;
  const CambiarEstadoUsuarioUseCase(this._repo);

  Future<Either<Failure, void>> call(String id, {required bool activo}) =>
      _repo.cambiarEstado(id, activo: activo);
}
