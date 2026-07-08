import '../../domain/entities/estado_inventario_item.dart';
import '../../domain/entities/indicador_turno.dart';
import '../remote/supabase_types.dart';

/// Mapeo de la vista `v_dashboard_turno`.
class IndicadorTurnoDto {
  static IndicadorTurno fromJson(Map<String, dynamic> j) => IndicadorTurno(
        turnoId: j[ColVDashboard.turnoId] as String,
        turnoNombre: j[ColVDashboard.turnoNombre] as String,
        ciclosEnCurso: (j[ColVDashboard.ciclosEnCurso] as num?)?.toInt() ?? 0,
        ciclosCompletados:
            (j[ColVDashboard.ciclosCompletados] as num?)?.toInt() ?? 0,
        minutosPromedio:
            (j[ColVDashboard.minutosPromedio] as num?)?.toDouble(),
      );
}

/// Mapeo de la vista `v_estado_inventario`.
class EstadoInventarioDto {
  static EstadoInventarioItem fromJson(Map<String, dynamic> j) =>
      EstadoInventarioItem(
        id: j[ColVInventario.id] as String,
        nombre: j[ColVInventario.nombre] as String,
        unidad: j[ColVInventario.unidad] as String,
        stockActual: (j[ColVInventario.stockActual] as num).toDouble(),
        umbralMinimo: (j[ColVInventario.umbralMinimo] as num).toDouble(),
        estadoStock: j[ColVInventario.estadoStock] as String,
      );
}
