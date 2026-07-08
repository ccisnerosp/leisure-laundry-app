import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/ciclo.dart';
import '../entities/estado_inventario_item.dart';
import '../entities/indicador_turno.dart';

/// Contrato del dashboard gerencial en tiempo real (OM-03, HU-04.1/04.2).
abstract interface class DashboardRepository {
  /// Indicadores del turno en curso (vista `v_dashboard_turno`).
  Future<Either<Failure, List<IndicadorTurno>>> indicadoresTurno();

  /// Estado del inventario con clasificación (vista `v_estado_inventario`).
  Future<Either<Failure, List<EstadoInventarioItem>>> estadoInventario();

  /// Ciclos actualmente en curso (todos los operarios).
  Future<Either<Failure, List<Ciclo>>> ciclosActivos();
}
