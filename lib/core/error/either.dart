/// Implementación liviana del tipo funcional `Either`, equivalente al de `dartz`.
///
/// Por convención: [Left] transporta el error ([Failure]) y [Right] el valor de
/// éxito. Todos los casos de uso y repositorios devuelven `Either<Failure, T>`.
library;

sealed class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  /// Devuelve el valor de error o `null` si es [Right].
  L? get leftOrNull => switch (this) {
        Left(value: final v) => v,
        Right() => null,
      };

  /// Devuelve el valor de éxito o `null` si es [Left].
  R? get rightOrNull => switch (this) {
        Right(value: final v) => v,
        Left() => null,
      };

  /// Pliega ambos casos en un único valor [T].
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return switch (this) {
      Left(value: final v) => onLeft(v),
      Right(value: final v) => onRight(v),
    };
  }

  /// Transforma el valor de éxito conservando el error.
  Either<L, T> map<T>(T Function(R right) transform) {
    return switch (this) {
      Left(value: final v) => Left(v),
      Right(value: final v) => Right(transform(v)),
    };
  }
}

final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}
