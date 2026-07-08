import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/dosis_programa.dart';
import '../../domain/entities/insumo.dart';
import '../../domain/entities/movimiento_inventario.dart';
import '../../domain/entities/turno.dart';
import '../../domain/repositories/movimiento_repository.dart';
import 'repository_providers.dart';
import 'usecase_providers.dart';

/// Turnos activos (para el filtro de historial por turno, HU-03.4).
final turnosProvider = FutureProvider.autoDispose<List<Turno>>((ref) async {
  final res = await ref.watch(turnoRepositoryProvider).listarActivos();
  return res.fold((f) => throw f, (data) => data);
});

/// Insumos del inventario (HU-03.3).
final insumosProvider = FutureProvider.autoDispose<List<Insumo>>((ref) async {
  final res = await ref.watch(listarInsumosUseCaseProvider).call(soloActivos: true);
  return res.fold((f) => throw f, (data) => data);
});

/// Dosis configuradas de un programa (HU-03.2).
final dosisPorProgramaProvider = FutureProvider.autoDispose
    .family<List<DosisPrograma>, String>((ref, programaId) async {
  final res = await ref.watch(listarDosisUseCaseProvider).call(programaId);
  return res.fold((f) => throw f, (data) => data);
});

/// Filtro actual del historial de consumo (HU-03.4).
final filtroHistorialProvider =
    StateProvider.autoDispose<FiltroMovimientos>((ref) => const FiltroMovimientos());

/// Historial de movimientos según el filtro activo.
final historialProvider =
    FutureProvider.autoDispose<List<MovimientoInventario>>((ref) async {
  final filtro = ref.watch(filtroHistorialProvider);
  final res = await ref.watch(consultarHistorialUseCaseProvider).call(filtro);
  return res.fold((f) => throw f, (data) => data);
});
