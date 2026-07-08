import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';
import '../../repositories/usuario_repository.dart';

/// HU-05.3 · Lista todos los usuarios para el perfil gerencial.
class ListarUsuariosUseCase {
  final UsuarioRepository _repo;
  const ListarUsuariosUseCase(this._repo);

  Future<Either<Failure, List<Usuario>>> call() => _repo.listar();
}
