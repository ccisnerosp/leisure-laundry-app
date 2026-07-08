import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formato.dart';
import '../../../domain/entities/insumo.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/inventario_providers.dart';
import '../../providers/usecase_providers.dart';
import '../../widgets/estado_views.dart';
import 'widgets/historial_tab.dart';
import 'widgets/registrar_ingreso_sheet.dart';

/// HU-03.3 / HU-03.4 · Inventario: stock actual e historial de consumo.
class InventarioScreen extends ConsumerWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.inventarioTitulo),
          bottom: const TabBar(
            tabs: [
              Tab(text: S.inventarioStock, icon: Icon(Icons.inventory_2)),
              Tab(text: S.inventarioHistorial, icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_StockTab(), HistorialTab()],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const RegistrarIngresoSheet(),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text(S.inventarioRegistrarIngreso),
        ),
      ),
    );
  }
}

class _StockTab extends ConsumerWidget {
  const _StockTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(insumosProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(insumosProvider),
      child: async.when(
        loading: () => const CargandoView(),
        error: (e, _) => ErrorView(
          mensaje: mensajeDeError(e),
          onReintentar: () => ref.invalidate(insumosProvider),
        ),
        data: (insumos) {
          if (insumos.isEmpty) {
            return ListView(children: const [
              SizedBox(height: 120),
              VacioView(mensaje: S.inventarioSinInsumos, icono: Icons.inventory),
            ]);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: insumos.length,
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemBuilder: (_, i) => _InsumoTile(insumo: insumos[i]),
          );
        },
      ),
    );
  }
}

class _InsumoTile extends ConsumerWidget {
  final Insumo insumo;
  const _InsumoTile({required this.insumo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = switch (insumo.estadoStock) {
      EstadoStock.critico => AppTheme.stockCritico,
      EstadoStock.bajo => AppTheme.stockBajo,
      EstadoStock.normal => AppTheme.stockNormal,
    };
    final u = S.unidadLabel(insumo.unidad.wire);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.science, color: Colors.white, size: 20),
        ),
        title: Text(insumo.nombre),
        subtitle: Text(
            '${S.inventarioUmbral}: ${Formato.cantidad(insumo.umbralMinimo)} $u'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${Formato.cantidad(insumo.stockActual)} $u',
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              tooltip: S.umbralEditar,
              icon: const Icon(Icons.tune),
              onPressed: () => _editarUmbral(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  // HU-04.3 · Configuración del umbral mínimo de stock.
  Future<void> _editarUmbral(BuildContext context, WidgetRef ref) async {
    final ctrl =
        TextEditingController(text: Formato.cantidad(insumo.umbralMinimo));
    final valor = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.umbralEditar),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: S.umbralLabel),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text(S.cancelar)),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, double.tryParse(ctrl.text.trim())),
            child: const Text(S.umbralGuardar),
          ),
        ],
      ),
    );
    if (valor == null) return;
    final res = await ref
        .read(actualizarUmbralUseCaseProvider)
        .call(insumoId: insumo.id, umbral: valor);
    if (!context.mounted) return;
    res.fold(
      (f) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(f.mensaje))),
      (_) {
        ref.invalidate(insumosProvider);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(S.umbralOk)));
      },
    );
  }
}
