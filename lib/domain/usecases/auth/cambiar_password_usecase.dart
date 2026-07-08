import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../repositories/auth_repository.dart';

/// HU-05.3 · Cambia la contraseña temporal en el primer inicio de sesión.
class CambiarPasswordUseCase {
  final AuthRepository _repo;
  const CambiarPasswordUseCase(this._repo);

  Future<Either<Failure, void>> call({
    required String nueva,
    required String confirmacion,
  }) {
    if (nueva.length < 6) {
      return Future.value(
          const Left(ValidationFailure(S.cambioPasswordMuyCorta)));
    }
    if (nueva != confirmacion) {
      return Future.value(
          const Left(ValidationFailure(S.cambioPasswordNoCoincide)));
    }
    return _repo.cambiarPassword(nueva);
  }
}
