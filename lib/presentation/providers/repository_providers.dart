import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/ciclo_repository_impl.dart';
import '../../data/repositories/cliente_repository_impl.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/repositories/dispositivo_repository_impl.dart';
import '../../data/repositories/dosis_repository_impl.dart';
import '../../data/repositories/insumo_repository_impl.dart';
import '../../data/repositories/movimiento_repository_impl.dart';
import '../../data/repositories/notificacion_repository_impl.dart';
import '../../data/repositories/programa_repository_impl.dart';
import '../../data/repositories/sync_repository_impl.dart';
import '../../data/repositories/turno_repository_impl.dart';
import '../../data/repositories/usuario_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/ciclo_repository.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/repositories/dispositivo_repository.dart';
import '../../domain/repositories/dosis_repository.dart';
import '../../domain/repositories/insumo_repository.dart';
import '../../domain/repositories/movimiento_repository.dart';
import '../../domain/repositories/notificacion_repository.dart';
import '../../domain/repositories/programa_repository.dart';
import '../../domain/repositories/sync_repository.dart';
import '../../domain/repositories/turno_repository.dart';
import '../../domain/repositories/usuario_repository.dart';
import 'core_providers.dart';

/// Inyección de dependencias de los repositorios. presentation/ siempre depende
/// de las interfaces de domain/, nunca de las implementaciones concretas.

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(supabaseClientProvider));
});

final programaRepositoryProvider = Provider<ProgramaRepository>((ref) {
  return ProgramaRepositoryImpl(ref.watch(supabaseClientProvider));
});

final usuarioRepositoryProvider = Provider<UsuarioRepository>((ref) {
  return UsuarioRepositoryImpl(ref.watch(supabaseClientProvider));
});

final clienteRepositoryProvider = Provider<ClienteRepository>((ref) {
  return ClienteRepositoryImpl(ref.watch(supabaseClientProvider));
});

final turnoRepositoryProvider = Provider<TurnoRepository>((ref) {
  return TurnoRepositoryImpl(ref.watch(supabaseClientProvider));
});

final cicloRepositoryProvider = Provider<CicloRepository>((ref) {
  return CicloRepositoryImpl(
    ref.watch(supabaseClientProvider),
    ref.watch(isarServiceProvider),
    ref.watch(connectivityServiceProvider),
    ref.watch(inventarioLocalServiceProvider),
  );
});

final insumoRepositoryProvider = Provider<InsumoRepository>((ref) {
  return InsumoRepositoryImpl(
    ref.watch(supabaseClientProvider),
    ref.watch(isarServiceProvider),
  );
});

final dosisRepositoryProvider = Provider<DosisRepository>((ref) {
  return DosisRepositoryImpl(
    ref.watch(supabaseClientProvider),
    ref.watch(isarServiceProvider),
  );
});

final movimientoRepositoryProvider = Provider<MovimientoRepository>((ref) {
  return MovimientoRepositoryImpl(ref.watch(supabaseClientProvider));
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepositoryImpl(
    ref.watch(supabaseClientProvider),
    ref.watch(isarServiceProvider),
  );
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(ref.watch(supabaseClientProvider));
});

final notificacionRepositoryProvider = Provider<NotificacionRepository>((ref) {
  return NotificacionRepositoryImpl(ref.watch(supabaseClientProvider));
});

final dispositivoRepositoryProvider = Provider<DispositivoRepository>((ref) {
  return DispositivoRepositoryImpl(ref.watch(supabaseClientProvider));
});
