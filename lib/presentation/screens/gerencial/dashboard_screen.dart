import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/router/rutas.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formato.dart';
import '../../../domain/entities/ciclo.dart';
import '../../../domain/entities/estado_inventario_item.dart';
import '../../../domain/entities/indicador_turno.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/core_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/conexion_banner.dart';
import '../../widgets/estado_views.dart';

/// HU-04.1 / HU-04.2 · Dashboard gerencial en tiempo real (landing gerencial).
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Suscripción Realtime: refresca las secciones ante cualquier cambio.
      ref.read(dashboardRealtimeServiceProvider).iniciar(
        onCiclos: () {
          ref.invalidate(ciclosActivosProvider);
          ref.invalidate(indicadoresTurnoProvider);
        },
        onInsumos: () => ref.invalidate(estadoInventarioProvider),
        onNotificaciones: () => ref.invalidate(notificacionesProvider),
      );
    });
  }

  void _refrescar() {
    ref.invalidate(indicadoresTurnoProvider);
    ref.invalidate(ciclosActivosProvider);
    ref.invalidate(estadoInventarioProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.dashboardTitulo),
        actions: [
          IconButton(
            tooltip: S.menuNotificaciones,
            icon: const Icon(Icons.notifications),
            onPressed: () => context.push(Rutas.gerencialNotificaciones),
          ),
          PopupMenuButton<String>(
            tooltip: S.menuConfiguracion,
            icon: const Icon(Icons.settings),
            onSelected: (ruta) => context.push(ruta),
            itemBuilder: (_) => const [
              PopupMenuItem(
                  value: Rutas.gerencialProgramas, child: Text(S.menuProgramas)),
              PopupMenuItem(
                  value: Rutas.gerencialUsuarios, child: Text(S.menuUsuarios)),
              PopupMenuItem(
                  value: Rutas.gerencialClientes, child: Text(S.menuClientes)),
              PopupMenuItem(
                  value: Rutas.gerencialInventario,
                  child: Text(S.inventarioTitulo)),
              PopupMenuItem(
                  value: Rutas.operario,
                  child: Text('${S.operarioTitulo} (${S.soloLectura})')),
            ],
          ),
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
            child: RefreshIndicator(
              onRefresh: () async => _refrescar(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  _SeccionIndicadores(),
                  SizedBox(height: 24),
                  _SeccionCiclosActivos(),
                  SizedBox(height: 24),
                  _SeccionStock(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TituloSeccion extends StatelessWidget {
  final String texto;
  const _TituloSeccion(this.texto);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(texto, style: Theme.of(context).textTheme.titleMedium),
      );
}

class _SeccionIndicadores extends ConsumerWidget {
  const _SeccionIndicadores();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(indicadoresTurnoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TituloSeccion(S.dashboardIndicadores),
        async.when(
          loading: () => const Padding(
              padding: EdgeInsets.all(8), child: LinearProgressIndicator()),
          error: (e, _) => ErrorView(mensaje: mensajeDeError(e)),
          data: (turnos) {
            // Muestra el turno activo (con ciclos) o el primero disponible.
            if (turnos.isEmpty) {
              return const VacioView(
                  mensaje: S.dashboardSinTurno, icono: Icons.schedule);
            }
            final t = turnos.firstWhere(
              (x) => x.ciclosEnCurso > 0 || x.ciclosCompletados > 0,
              orElse: () => turnos.first,
            );
            return _IndicadoresCard(turno: t);
          },
        ),
      ],
    );
  }
}

class _IndicadoresCard extends StatelessWidget {
  final IndicadorTurno turno;
  const _IndicadoresCard({required this.turno});

  @override
  Widget build(BuildContext context) {
    final prom = turno.minutosPromedio;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(turno.turnoNombre,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Metric(
                    valor: '${turno.ciclosEnCurso}',
                    etiqueta: S.indCiclosEnCurso),
                _Metric(
                    valor: '${turno.ciclosCompletados}',
                    etiqueta: S.indCiclosCompletados),
                _Metric(
                    valor: prom == null ? '—' : prom.toStringAsFixed(0),
                    etiqueta: S.indPromedio),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String valor;
  final String etiqueta;
  const _Metric({required this.valor, required this.etiqueta});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(valor, style: Theme.of(context).textTheme.headlineMedium),
          Text(etiqueta, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
}

class _SeccionCiclosActivos extends ConsumerWidget {
  const _SeccionCiclosActivos();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(ciclosActivosProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TituloSeccion(S.dashboardCiclosActivos),
        async.when(
          loading: () => const Padding(
              padding: EdgeInsets.all(8), child: LinearProgressIndicator()),
          error: (e, _) => ErrorView(mensaje: mensajeDeError(e)),
          data: (ciclos) {
            if (ciclos.isEmpty) {
              return const VacioView(
                  mensaje: S.dashboardSinCiclosActivos,
                  icono: Icons.hourglass_empty);
            }
            return Column(
                children: [for (final c in ciclos) _CicloActivoTile(ciclo: c)]);
          },
        ),
      ],
    );
  }
}

class _CicloActivoTile extends StatelessWidget {
  final Ciclo ciclo;
  const _CicloActivoTile({required this.ciclo});
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const Icon(Icons.hourglass_top),
          title: Text(ciclo.programaNombre ?? '—'),
          subtitle: Text(
              '${ciclo.clienteNombre ?? '—'} · ${Formato.fechaHora(ciclo.inicioEn)}'),
        ),
      );
}

class _SeccionStock extends ConsumerWidget {
  const _SeccionStock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(estadoInventarioProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TituloSeccion(S.dashboardStock),
        async.when(
          loading: () => const Padding(
              padding: EdgeInsets.all(8), child: LinearProgressIndicator()),
          error: (e, _) => ErrorView(mensaje: mensajeDeError(e)),
          data: (items) {
            if (items.isEmpty) {
              return const VacioView(
                  mensaje: S.inventarioSinInsumos, icono: Icons.inventory);
            }
            return Column(
                children: [for (final i in items) _StockTile(item: i)]);
          },
        ),
      ],
    );
  }
}

class _StockTile extends StatelessWidget {
  final EstadoInventarioItem item;
  const _StockTile({required this.item});
  @override
  Widget build(BuildContext context) {
    final color = switch (item.estadoStock) {
      'critico' => AppTheme.stockCritico,
      'bajo' => AppTheme.stockBajo,
      _ => AppTheme.stockNormal,
    };
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.science, color: Colors.white, size: 20),
        ),
        title: Text(item.nombre),
        subtitle: Text(S.estadoStockLabel(item.estadoStock),
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        trailing: Text(
          '${Formato.cantidad(item.stockActual)} ${S.unidadLabel(item.unidad)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
