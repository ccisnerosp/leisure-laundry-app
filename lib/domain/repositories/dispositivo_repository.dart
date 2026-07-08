import '../../core/error/either.dart';
import '../../core/error/failure.dart';

/// Contrato para registrar el token FCM del dispositivo (HU-04.5).
abstract interface class DispositivoRepository {
  /// Registra/actualiza el token FCM del usuario gerencial (upsert por token).
  Future<Either<Failure, void>> registrarToken({
    required String usuarioId,
    required String token,
    required String plataforma,
  });
}
