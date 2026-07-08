import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/utils/formato.dart';
import '../../../domain/entities/notificacion_stock.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-04.6 · Historial de notificaciones de stock crítico (filtrable por fecha).
class NotificacionesScreen extends ConsumerWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificacionesProvider);
    final rango = ref.watch(filtroNotificacionesProvider);

    Future<void> pick(bool desde) async {
      final r = await showDatePicker(
        context: context,
        initialDate: (desde ? rango.desde : rango.hasta) ?? DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100),
      );
      if (r == null) return;
      ref.read(filtroNotificacionesProvider.notifier).state = (
        desde: desde ? DateTime(r.year, r.month, r.day) : rango.desde,
        hasta: desde
            ? rango.hasta
            : DateTime(r.year, r.month, r.day, 23, 59, 59),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text(S.notifHistorialTitulo)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today, size: 18),
                    onPressed: () => pick(true),
                    label: Text(rango.desde == null
                        ? S.historialFiltroDesde
                        : Formato.fechaHora(rango.desde!).split(' ').first),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.event, size: 18),
                    onPressed: () => pick(false),
                    label: Text(rango.hasta == null
                        ? S.historialFiltroHasta
                        : Formato.fechaHora(rango.hasta!).split(' ').first),
                  ),
                ),
                if (rango.desde != null || rango.hasta != null)
                  IconButton(
                    tooltip: S.cancelar,
                    icon: const Icon(Icons.clear),
                    onPressed: () => ref
                        .read(filtroNotificacionesProvider.notifier)
                        .state = (desde: null, hasta: null),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.invalidate(notificacionesProvider),
              child: async.when(
                loading: () => const CargandoView(),
                error: (e, _) => ErrorView(
                  mensaje: mensajeDeError(e),
                  onReintentar: () => ref.invalidate(notificacionesProvider),
                ),
                data: (notifs) {
                  if (notifs.isEmpty) {
                    return ListView(children: const [
                      SizedBox(height: 120),
                      VacioView(
                          mensaje: S.notifHistorialVacio,
                          icono: Icons.notifications_off),
                    ]);
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: notifs.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (_, i) => _NotifTile(notif: notifs[i]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final NotificacionStock notif;
  const _NotifTile({required this.notif});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        leading: Icon(Icons.warning_amber,
            color: notif.atendida ? Colors.green : cs.error),
        title: Text(notif.insumoNombre ?? notif.insumoId),
        subtitle: Text(
          '${Formato.fechaHora(notif.generadaEn)}\n'
          'Stock: ${Formato.cantidad(notif.stockAlDisparar)} '
          '(umbral ${Formato.cantidad(notif.umbralAlDisparar)})',
        ),
        isThreeLine: true,
        trailing: Text(
          notif.atendida ? S.notifAtendida : S.notifPendiente,
          style: TextStyle(
              color: notif.atendida ? Colors.green : cs.error,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
