import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/insumo.dart';

/// Contrato del catálogo de insumos y su stock (OM-02).
abstract interface class InsumoRepository {
  Future<Either<Failure, List<Insumo>>> listar({bool soloActivos = true});

  /// HU-03.3 · Registra un ingreso de stock: suma [cantidad] al insumo y deja
  /// un movimiento de tipo `ingreso`. Devuelve el insumo con su stock final.
  Future<Either<Failure, Insumo>> registrarIngreso({
    required String insumoId,
    required double cantidad,
    required String usuarioId,
  });

  /// HU-04.3 · Actualiza el umbral mínimo de un insumo.
  Future<Either<Failure, Insumo>> actualizarUmbral({
    required String insumoId,
    required double umbral,
  });
}
