import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../domain/entities/cliente.dart';
import '../../../domain/entities/enums.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/usecase_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-05.1 · Gestión de clientes.
class ClientesScreen extends ConsumerWidget {
  const ClientesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(clientesGestionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(S.clientesTitulo)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(context, ref, null),
        icon: const Icon(Icons.add),
        label: const Text(S.clienteNuevo),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(clientesGestionProvider),
        child: async.when(
          loading: () => const CargandoView(),
          error: (e, _) => ErrorView(
            mensaje: mensajeDeError(e),
            onReintentar: () => ref.invalidate(clientesGestionProvider),
          ),
          data: (clientes) {
            if (clientes.isEmpty) {
              return ListView(children: const [
                SizedBox(height: 120),
                VacioView(mensaje: S.clienteSinRegistros, icono: Icons.apartment),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: clientes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final c = clientes[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.apartment),
                    title: Text(c.nombre),
                    subtitle: Text(
                      '${S.tipoClienteLabel(c.tipo.wire)}'
                      '${c.zona != null ? ' · ${c.zona}' : ''}'
                      ' · ${c.activo ? S.activo : S.inactivo}',
                    ),
                    onTap: () => _abrirForm(context, ref, c),
                    trailing: Switch(
                      value: c.activo,
                      onChanged: (v) async {
                        await ref
                            .read(cambiarEstadoClienteUseCaseProvider)
                            .call(c.id, activo: v);
                        ref.invalidate(clientesGestionProvider);
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

  void _abrirForm(BuildContext context, WidgetRef ref, Cliente? existente) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ClienteForm(existente: existente),
      ),
    );
  }
}

class _ClienteForm extends ConsumerStatefulWidget {
  final Cliente? existente;
  const _ClienteForm({this.existente});

  @override
  ConsumerState<_ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends ConsumerState<_ClienteForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _contactoCtrl;
  late final TextEditingController _zonaCtrl;
  late TipoCliente _tipo;
  late bool _activo;
  bool _guardando = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existente;
    _nombreCtrl = TextEditingController(text: e?.nombre ?? '');
    _contactoCtrl = TextEditingController(text: e?.contacto ?? '');
    _zonaCtrl = TextEditingController(text: e?.zona ?? '');
    _tipo = e?.tipo ?? TipoCliente.hotel;
    _activo = e?.activo ?? true;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _contactoCtrl.dispose();
    _zonaCtrl.dispose();
    super.dispose();
  }

  String? _trimOrNull(String s) => s.trim().isEmpty ? null : s.trim();

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _guardando = true;
      _error = null;
    });

    final res = widget.existente == null
        ? await ref.read(crearClienteUseCaseProvider).call(
              nombre: _nombreCtrl.text,
              tipo: _tipo,
              contacto: _trimOrNull(_contactoCtrl.text),
              zona: _trimOrNull(_zonaCtrl.text),
            )
        : await ref.read(actualizarClienteUseCaseProvider).call(
              widget.existente!.copyWith(
                nombre: _nombreCtrl.text.trim(),
                tipo: _tipo,
                contacto: _trimOrNull(_contactoCtrl.text),
                zona: _trimOrNull(_zonaCtrl.text),
                activo: _activo,
              ),
            );
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _guardando = false;
        _error = f.mensaje;
      }),
      (_) {
        ref.invalidate(clientesGestionProvider);
        ref.invalidate(clientesActivosProvider);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.existente != null;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(esEdicion ? S.clienteEditar : S.clienteNuevo,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: S.clienteNombre),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? S.clienteErrorNombre : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TipoCliente>(
              value: _tipo,
              decoration: const InputDecoration(labelText: S.clienteTipo),
              items: const [
                DropdownMenuItem(
                    value: TipoCliente.hotel, child: Text(S.clienteTipoHotel)),
                DropdownMenuItem(
                    value: TipoCliente.airbnb, child: Text(S.clienteTipoAirbnb)),
                DropdownMenuItem(
                    value: TipoCliente.otro, child: Text(S.clienteTipoOtro)),
              ],
              onChanged: (v) => setState(() => _tipo = v ?? TipoCliente.hotel),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contactoCtrl,
              decoration: const InputDecoration(labelText: S.clienteContacto),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _zonaCtrl,
              decoration: const InputDecoration(labelText: S.clienteZona),
            ),
            if (esEdicion)
              SwitchListTile(
                title: const Text(S.activo),
                value: _activo,
                onChanged: (v) => setState(() => _activo = v),
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
                  : const Text(S.clienteGuardar),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
