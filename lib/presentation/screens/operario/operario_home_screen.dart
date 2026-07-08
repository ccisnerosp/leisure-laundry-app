import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/router/rutas.dart';
import '../../../core/utils/formato.dart';
import '../../../domain/entities/ciclo.dart';
import '../../../domain/entities/enums.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/ciclo_providers.dart';
import '../../widgets/conexion_banner.dart';
import '../../widgets/estado_views.dart';
import 'widgets/ciclo_finalizado_view.dart';
import 'widgets/temporizador_card.dart';

/// HU-02.2/02.3/02.4 · Módulo de gestión de ciclos del operario.
class OperarioHomeScreen extends ConsumerStatefulWidget {
  const OperarioHomeScreen({super.key});

  @override
  ConsumerState<OperarioHomeScreen> createState() =>
      _OperarioHomeScreenState();
}

class _OperarioHomeScreenState extends ConsumerState<OperarioHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Reanuda un ciclo en curso tras reabrir la app.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usuario = ref.read(usuarioActualProvider);
      if (usuario != null) {
        ref.read(cicloControllerProvider.notifier).reanudar(usuario.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(usuarioActualProvider);
    final estado = ref.watch(cicloControllerProvider);
    final soloLectura = usuario?.esGerencial ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(S.operarioTitulo),
        actions: [
          IconButton(
            tooltip: S.cerrarSesion,
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(authControllerProvider.notifier).cerrarSesion(),
          ),
        ],
      ),
      body: Column(
        children: [
          const ConexionBanner(),
          Expanded(
            child: switch (estado) {
              CicloIniciando() => const CargandoView(),
              CicloErrorState(failure: final f) =>
                ErrorView(mensaje: f.mensaje, onReintentar: () {
                  final u = ref.read(usuarioActualProvider);
                  if (u != null) {
                    ref.read(cicloControllerProvider.notifier).reanudar(u.id);
                  }
                }),
              CicloCorriendo(ciclo: final c, restante: final r) =>
                TemporizadorCard(ciclo: c, restante: r),
              CicloFinalizado(ciclo: final c) => CicloFinalizadoView(ciclo: c),
              CicloInactivo() => _HistorialView(soloLectura: soloLectura),
            },
          ),
        ],
      ),
      floatingActionButton: (estado is CicloInactivo && !soloLectura)
          ? FloatingActionButton.extended(
              onPressed: () => context.push(Rutas.operarioIniciar),
              icon: const Icon(Icons.add),
              label: const Text(S.operarioNuevoCiclo),
            )
          : null,
    );
  }
}

class _HistorialView extends ConsumerWidget {
  final bool soloLectura;
  const _HistorialView({required this.soloLectura});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    if (usuario == null) return const CargandoView();
    final ciclosAsync = ref.watch(ciclosUsuarioProvider(usuario.id));

    return RefreshIndicator(
      onRefresh: () async =>
          ref.invalidate(ciclosUsuarioProvider(usuario.id)),
      child: ciclosAsync.when(
        loading: () => const CargandoView(),
        error: (e, _) => ErrorView(
          mensaje: mensajeDeError(e),
          onReintentar: () =>
              ref.invalidate(ciclosUsuarioProvider(usuario.id)),
        ),
        data: (ciclos) {
          if (ciclos.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 120),
                VacioView(
                    mensaje: S.operarioSinCiclos,
                    icono: Icons.local_laundry_service),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: ciclos.length,
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemBuilder: (_, i) => _CicloTile(ciclo: ciclos[i]),
          );
        },
      ),
    );
  }
}

class _CicloTile extends StatelessWidget {
  final Ciclo ciclo;
  const _CicloTile({required this.ciclo});

  @override
  Widget build(BuildContext context) {
    final (icono, color, etiqueta) = switch (ciclo.estado) {
      EstadoCiclo.enCurso => (
          Icons.hourglass_top,
          Theme.of(context).colorScheme.primary,
          S.cicloEstadoEnCurso,
        ),
      EstadoCiclo.completado => (
          Icons.check_circle,
          Colors.green,
          S.cicloEstadoCompletado,
        ),
      EstadoCiclo.cancelado => (
          Icons.cancel,
          Theme.of(context).disabledColor,
          S.cicloEstadoCancelado,
        ),
    };
    return Card(
      child: ListTile(
        leading: Icon(icono, color: color),
        title: Text(ciclo.programaNombre ?? '—'),
        subtitle: Text(
            '${ciclo.clienteNombre ?? '—'} · ${Formato.fechaHora(ciclo.inicioEn)}'),
        trailing: Text(etiqueta, style: TextStyle(color: color)),
      ),
    );
  }
}
