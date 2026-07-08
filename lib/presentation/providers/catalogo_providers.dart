import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/entities/programa.dart';
import '../../domain/entities/usuario.dart';
import 'usecase_providers.dart';

/// Lista de programas. El parámetro indica si solo se quieren los activos
/// (true → para el operario; false → catálogo completo del gerencial).
final programasProvider =
    FutureProvider.autoDispose.family<List<Programa>, bool>((ref, soloActivos) async {
  final res = await ref
      .watch(listarProgramasUseCaseProvider)
      .call(soloActivos: soloActivos);
  return res.fold((f) => throw f, (data) => data);
});

/// Lista de usuarios (HU-05.3).
final usuariosProvider =
    FutureProvider.autoDispose<List<Usuario>>((ref) async {
  final res = await ref.watch(listarUsuariosUseCaseProvider).call();
  return res.fold((f) => throw f, (data) => data);
});

/// Clientes activos para vincular a un ciclo (HU-02.1).
final clientesActivosProvider =
    FutureProvider.autoDispose<List<Cliente>>((ref) async {
  final res =
      await ref.watch(listarClientesUseCaseProvider).call(soloActivos: true);
  return res.fold((f) => throw f, (data) => data);
});

/// Todos los clientes para la pantalla de gestión (HU-05.1).
final clientesGestionProvider =
    FutureProvider.autoDispose<List<Cliente>>((ref) async {
  final res =
      await ref.watch(listarClientesUseCaseProvider).call(soloActivos: false);
  return res.fold((f) => throw f, (data) => data);
});

/// Helper para extraer un mensaje legible de un error de AsyncValue.
String mensajeDeError(Object error) =>
    error is Failure ? error.mensaje : error.toString();
