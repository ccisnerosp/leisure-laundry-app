import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/dispositivo_repository.dart';

/// HU-04.5 · Registra el token FCM del dispositivo del usuario.
class RegistrarTokenUseCase {
  final DispositivoRepository _repo;
  const RegistrarTokenUseCase(this._repo);

  Future<Either<Failure, void>> call({
    required String usuarioId,
    required String token,
    required String plataforma,
  }) =>
      _repo.registrarToken(
          usuarioId: usuarioId, token: token, plataforma: plataforma);
}
