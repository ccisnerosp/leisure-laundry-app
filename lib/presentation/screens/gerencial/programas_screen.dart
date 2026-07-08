import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../core/router/rutas.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/programa.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/usecase_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-05.2 · Gestión de programas de lavado y secado.
class ProgramasScreen extends ConsumerWidget {
  const ProgramasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(programasProvider(false));

    return Scaffold(
      appBar: AppBar(title: const Text(S.programasTitulo)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(context, ref, null),
        icon: const Icon(Icons.add),
        label: const Text(S.programaNuevo),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(programasProvider(false)),
        child: async.when(
          loading: () => const CargandoView(),
          error: (e, _) => ErrorView(
            mensaje: mensajeDeError(e),
            onReintentar: () => ref.invalidate(programasProvider(false)),
          ),
          data: (programas) {
            if (programas.isEmpty) {
              return ListView(children: const [
                SizedBox(height: 120),
                VacioView(
                    mensaje: S.programaSinRegistros, icono: Icons.settings),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: programas.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final p = programas[i];
                return Card(
                  child: ListTile(
                    leading: Icon(p.tipo == TipoPrograma.lavado
                        ? Icons.local_laundry_service
                        : Icons.dry),
                    title: Text(p.nombre),
                    subtitle: Text(
                      '${p.tipo == TipoPrograma.lavado ? S.programaTipoLavado : S.programaTipoSecado}'
                      ' · ${p.duracionMinutos} min · ${p.activo ? S.activo : S.inactivo}',
                    ),
                    onTap: () => _abrirForm(context, ref, p),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: S.dosisTitulo,
                          icon: const Icon(Icons.science),
                          onPressed: () =>
                              context.push(Rutas.gerencialDosis, extra: p),
                        ),
                        Switch(
                          value: p.activo,
                          onChanged: (v) async {
                            await ref
                                .read(cambiarEstadoProgramaUseCaseProvider)
                                .call(p.id, activo: v);
                            ref.invalidate(programasProvider(false));
                          },
                        ),
                      ],
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

  void _abrirForm(BuildContext context, WidgetRef ref, Programa? existente) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ProgramaForm(existente: existente),
      ),
    );
  }
}

class _ProgramaForm extends ConsumerStatefulWidget {
  final Programa? existente;
  const _ProgramaForm({this.existente});

  @override
  ConsumerState<_ProgramaForm> createState() => _ProgramaFormState();
}

class _ProgramaFormState extends ConsumerState<_ProgramaForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _duracionCtrl;
  late TipoPrograma _tipo;
  late bool _activo;
  bool _guardando = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existente;
    _nombreCtrl = TextEditingController(text: e?.nombre ?? '');
    _duracionCtrl =
        TextEditingController(text: e?.duracionMinutos.toString() ?? '');
    _tipo = e?.tipo ?? TipoPrograma.lavado;
    _activo = e?.activo ?? true;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _duracionCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final duracion = int.tryParse(_duracionCtrl.text.trim()) ?? 0;

    final res = widget.existente == null
        ? await ref.read(crearProgramaUseCaseProvider).call(
              nombre: _nombreCtrl.text,
              tipo: _tipo,
              duracionMinutos: duracion,
            )
        : await ref.read(actualizarProgramaUseCaseProvider).call(
              widget.existente!.copyWith(
                nombre: _nombreCtrl.text.trim(),
                tipo: _tipo,
                duracionMinutos: duracion,
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
        ref.invalidate(programasProvider(false));
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
            Text(esEdicion ? S.programaEditar : S.programaNuevo,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nombreCtrl,
              decoration:
                  const InputDecoration(labelText: S.programaNombre),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? S.programaErrorNombre : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TipoPrograma>(
              value: _tipo,
              decoration: const InputDecoration(labelText: S.programaTipo),
              items: const [
                DropdownMenuItem(
                    value: TipoPrograma.lavado,
                    child: Text(S.programaTipoLavado)),
                DropdownMenuItem(
                    value: TipoPrograma.secado,
                    child: Text(S.programaTipoSecado)),
              ],
              onChanged: (v) => setState(() => _tipo = v ?? TipoPrograma.lavado),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _duracionCtrl,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: S.programaDuracion),
              validator: (v) {
                final n = int.tryParse((v ?? '').trim());
                if (n == null || n < 1 || n > 240) {
                  return S.programaErrorDuracion;
                }
                return null;
              },
            ),
            if (esEdicion) ...[
              const SizedBox(height: 4),
              SwitchListTile(
                title: const Text(S.programaActivo),
                value: _activo,
                onChanged: (v) => setState(() => _activo = v),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: _guardando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text(S.programaGuardar),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
