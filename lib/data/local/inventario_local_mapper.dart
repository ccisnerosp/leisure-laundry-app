import '../../domain/entities/dosis_programa.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/insumo.dart';
import '../../domain/entities/movimiento_inventario.dart';
import 'models/dosis_local.dart';
import 'models/insumo_local.dart';
import 'models/movimiento_inventario_local.dart';

abstract class InsumoLocalMapper {
  static InsumoLocal fromEntity(Insumo i) => InsumoLocal()
    ..id = i.id
    ..nombre = i.nombre
    ..unidad = i.unidad.wire
    ..stockActual = i.stockActual
    ..umbralMinimo = i.umbralMinimo
    ..activo = i.activo;

  static Insumo toEntity(InsumoLocal l) => Insumo(
        id: l.id,
        nombre: l.nombre,
        unidad: UnidadInsumo.fromWire(l.unidad),
        stockActual: l.stockActual,
        umbralMinimo: l.umbralMinimo,
        activo: l.activo,
      );
}

abstract class MovimientoLocalMapper {
  static MovimientoInventarioLocal fromEntity(MovimientoInventario m) =>
      MovimientoInventarioLocal()
        ..id = m.id
        ..insumoId = m.insumoId
        ..cicloId = m.cicloId
        ..usuarioId = m.usuarioId
        ..tipo = m.tipo.wire
        ..cantidad = m.cantidad
        ..stockResultante = m.stockResultante
        ..registradoEn = m.registradoEn
        ..sincronizado = m.sincronizado
        ..insumoNombre = m.insumoNombre;

  static MovimientoInventario toEntity(MovimientoInventarioLocal l) =>
      MovimientoInventario(
        id: l.id,
        insumoId: l.insumoId,
        cicloId: l.cicloId,
        usuarioId: l.usuarioId,
        tipo: TipoMovimiento.fromWire(l.tipo),
        cantidad: l.cantidad,
        stockResultante: l.stockResultante,
        registradoEn: l.registradoEn,
        sincronizado: l.sincronizado,
        insumoNombre: l.insumoNombre,
      );
}

abstract class DosisLocalMapper {
  static DosisLocal fromEntity(DosisPrograma d) => DosisLocal()
    ..id = d.id
    ..programaId = d.programaId
    ..insumoId = d.insumoId
    ..dosis = d.dosis
    ..insumoNombre = d.insumoNombre
    ..insumoUnidad = d.insumoUnidad;

  static DosisPrograma toEntity(DosisLocal l) => DosisPrograma(
        id: l.id,
        programaId: l.programaId,
        insumoId: l.insumoId,
        dosis: l.dosis,
        insumoNombre: l.insumoNombre,
        insumoUnidad: l.insumoUnidad,
      );
}
