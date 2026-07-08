/// Jerarquía de errores de dominio. Las capas superiores nunca ven excepciones
/// crudas: todo error se traduce a un [Failure] con un mensaje presentable.
sealed class Failure {
  /// Clave de texto (de `strings_es.dart`) ya resuelta a un mensaje legible.
  final String mensaje;
  const Failure(this.mensaje);

  @override
  String toString() => '$runtimeType($mensaje)';
}

/// Error de autenticación (credenciales inválidas, sesión expirada, etc.).
class AuthFailure extends Failure {
  const AuthFailure(super.mensaje);
}

/// Error de comunicación con el servidor (Supabase / red).
class ServerFailure extends Failure {
  const ServerFailure(super.mensaje);
}

/// Error de conectividad (sin internet).
class NetworkFailure extends Failure {
  const NetworkFailure(super.mensaje);
}

/// Error de la base de datos local (Isar).
class CacheFailure extends Failure {
  const CacheFailure(super.mensaje);
}

/// Error de validación de datos de entrada.
class ValidationFailure extends Failure {
  const ValidationFailure(super.mensaje);
}

/// Error inesperado no clasificado.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.mensaje);
}
