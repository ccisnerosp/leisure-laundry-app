import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/utils/formato.dart';
import '../../../domain/entities/insumo.dart';
import '../../../domain/entities/programa.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/inventario_providers.dart';
import '../../providers/usecase_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-03.2 · Configuración de dosis de insumos por programa.
class DosisScreen extends ConsumerWidget {
  final Programa programa;
  const DosisScreen({super.key, required this.programa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dosisPorProgramaProvider(programa.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text(S.dosisTitulo),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(programa.nombre,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text(S.dosisAgregar),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.invalidate(dosisPorProgramaProvider(programa.id)),
        child: async.when(
          loading: () => const CargandoView(),
          error: (e, _) => ErrorView(
            mensaje: mensajeDeError(e),
            onReintentar: () =>
                ref.invalidate(dosisPorProgramaProvider(programa.id)),
          ),
          data: (dosis) {
            if (dosis.isEmpty) {
              return ListView(children: const [
                SizedBox(height: 120),
                VacioView(mensaje: S.dosisSinRegistros, icono: Icons.science),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: dosis.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final d = dosis[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.science),
                    title: Text(d.insumoNombre ?? d.insumoId),
                    subtitle: Text(
                        '${Formato.cantidad(d.dosis)} ${S.unidadLabel(d.insumoUnidad ?? '')}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await ref
                            .read(eliminarDosisUseCaseProvider)
                            .call(d.id);
                        ref.invalidate(dosisPorProgramaProvider(programa.id));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _abrirForm(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _DosisForm(programaId: programa.id),
      ),
    );
  }
}

class _DosisForm extends ConsumerStatefulWidget {
  final String programaId;
  const _DosisForm({required this.programaId});

  @override
  ConsumerState<_DosisForm> createState() => _DosisFormState();
}

class _DosisFormState extends ConsumerState<_DosisForm> {
  final _formKey = GlobalKey<FormState>();
  final _dosisCtrl = TextEditingController();
  Insumo? _insumo;
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _dosisCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_insumo == null) {
      setState(() => _error = S.dosisErrorInsumo);
      return;
    }
    setState(() {
      _guardando = true;
      _error = null;
    });
    final res = await ref.read(guardarDosisUseCaseProvider).call(
          programaId: widget.programaId,
          insumoId: _insumo!.id,
          dosis: double.parse(_dosisCtrl.text.trim()),
        );
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _guardando = false;
        _error = f.mensaje;
      }),
      (_) {
        ref.invalidate(dosisPorProgramaProvider(widget.programaId));
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final insumosAsync = ref.watch(insumosProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.dosisAgregar,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            insumosAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(8),
                child: LinearProgressIndicator(),
              ),
              error: (e, _) => ErrorView(mensaje: mensajeDeError(e)),
              data: (insumos) => DropdownButtonFormField<Insumo>(
                value: _insumo,
                isExpanded: true,
                decoration: const InputDecoration(labelText: S.dosisInsumo),
                items: [
                  for (final i in insumos)
                    DropdownMenuItem(
                        value: i,
                        child: Text('${i.nombre} (${S.unidadLabel(i.unidad.wire)})')),
                ],
                onChanged: (v) => setState(() => _insumo = v),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _dosisCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: S.dosisCantidad),
              validator: (v) {
                final n = double.tryParse((v ?? '').trim());
                if (n == null || n <= 0) return S.dosisErrorValor;
                return null;
              },
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: _guardando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text(S.dosisGuardar),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
