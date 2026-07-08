import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ciclo.dart';
import '../../domain/entities/estado_inventario_item.dart';
import '../../domain/entities/indicador_turno.dart';
import '../../domain/entities/notificacion_stock.dart';
import 'usecase_providers.dart';

/// Indicadores del turno en curso (HU-04.2).
final indicadoresTurnoProvider =
    FutureProvider.autoDispose<List<IndicadorTurno>>((ref) async {
  final res = await ref.watch(obtenerIndicadoresTurnoUseCaseProvider).call();
  return res.fold((f) => throw f, (data) => data);
});

/// Estado del inventario con clasificación (HU-04.1).
final estadoInventarioProvider =
    FutureProvider.autoDispose<List<EstadoInventarioItem>>((ref) async {
  final res = await ref.watch(obtenerEstadoInventarioUseCaseProvider).call();
  return res.fold((f) => throw f, (data) => data);
});

/// Ciclos en curso (HU-04.1).
final ciclosActivosProvider =
    FutureProvider.autoDispose<List<Ciclo>>((ref) async {
  final res = await ref.watch(obtenerCiclosActivosUseCaseProvider).call();
  return res.fold((f) => throw f, (data) => data);
});

/// Rango de fechas del historial de notificaciones (HU-04.6).
typedef RangoFechas = ({DateTime? desde, DateTime? hasta});

final filtroNotificacionesProvider =
    StateProvider.autoDispose<RangoFechas>((ref) => (desde: null, hasta: null));

/// Historial de notificaciones de stock crítico (HU-04.6).
final notificacionesProvider =
    FutureProvider.autoDispose<List<NotificacionStock>>((ref) async {
  final r = ref.watch(filtroNotificacionesProvider);
  final res = await ref
      .watch(consultarNotificacionesUseCaseProvider)
      .call(desde: r.desde, hasta: r.hasta);
  return res.fold((f) => throw f, (data) => data);
});
