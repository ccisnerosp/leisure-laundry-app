import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/dosis_programa.dart';

/// Contrato de configuración de dosis por programa (HU-03.2, tabla
/// `programa_insumo`).
abstract interface class DosisRepository {
  Future<Either<Failure, List<DosisPrograma>>> listarPorPrograma(
      String programaId);

  /// Crea o actualiza la dosis de un insumo para un programa (upsert por la
  /// clave única programa_id + insumo_id).
  Future<Either<Failure, DosisPrograma>> guardar({
    required String programaId,
    required String insumoId,
    required double dosis,
  });

  Future<Either<Failure, void>> eliminar(String dosisId);
}
