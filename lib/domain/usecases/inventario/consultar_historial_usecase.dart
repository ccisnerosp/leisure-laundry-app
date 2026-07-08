import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/movimiento_inventario.dart';
import '../../repositories/movimiento_repository.dart';

/// HU-03.4 · Consulta el historial de consumo filtrando por insumo, fecha y turno.
class ConsultarHistorialUseCase {
  final MovimientoRepository _repo;
  const ConsultarHistorialUseCase(this._repo);

  Future<Either<Failure, List<MovimientoInventario>>> call(
          FiltroMovimientos filtro) =>
      _repo.historial(filtro);
}
