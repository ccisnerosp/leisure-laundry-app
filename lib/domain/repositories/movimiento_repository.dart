import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/movimiento_inventario.dart';

/// Filtros del historial de consumo (HU-03.4).
class FiltroMovimientos {
  final String? insumoId;
  final DateTime? desde;
  final DateTime? hasta;
  final String? turnoId;

  const FiltroMovimientos({
    this.insumoId,
    this.desde,
    this.hasta,
    this.turnoId,
  });
}

/// Contrato del historial de movimientos de inventario (HU-03.4).
abstract interface class MovimientoRepository {
  Future<Either<Failure, List<MovimientoInventario>>> historial(
      FiltroMovimientos filtro);
}
