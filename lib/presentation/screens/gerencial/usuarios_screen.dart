import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../domain/entities/enums.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/usecase_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-05.3 · Gestión de usuarios operarios.
class UsuariosScreen extends ConsumerWidget {
  const UsuariosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(usuariosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(S.usuariosTitulo)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(context, ref),
        icon: const Icon(Icons.person_add),
        label: const Text(S.usuarioNuevo),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(usuariosProvider),
        child: async.when(
          loading: () => const CargandoView(),
          error: (e, _) => ErrorView(
            mensaje: mensajeDeError(e),
            onReintentar: () => ref.invalidate(usuariosProvider),
          ),
          data: (usuarios) {
            if (usuarios.isEmpty) {
              return ListView(children: const [
                SizedBox(height: 120),
                VacioView(mensaje: S.usuarioSinRegistros, icono: Icons.people),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: usuarios.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final u = usuarios[i];
                return Card(
                  child: ListTile(
                    leading: Icon(u.esGerencial
                        ? Icons.admin_panel_settings
                        : Icons.engineering),
                    title: Text(u.nombre),
                    subtitle: Text(
                      '${u.email}\n${u.esGerencial ? S.usuarioRolGerencial : S.usuarioRolOperario}'
                      ' · ${u.activo ? S.activo : S.inactivo}',
                    ),
                    isThreeLine: true,
                    trailing: Switch(
                      value: u.activo,
                      onChanged: (v) async {
                        await ref
                            .read(cambiarEstadoUsuarioUseCaseProvider)
                            .call(u.id, activo: v);
                        ref.invalidate(usuariosProvider);
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
        child: const _UsuarioForm(),
      ),
    );
  }
}

class _UsuarioForm extends ConsumerStatefulWidget {
  const _UsuarioForm();

  @override
  ConsumerState<_UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends ConsumerState<_UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  RolUsuario _rol = RolUsuario.operario;
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final res = await ref.read(crearUsuarioUseCaseProvider).call(
          nombre: _nombreCtrl.text,
          email: _emailCtrl.text,
          rol: _rol,
          passwordInicial: _passCtrl.text,
        );
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _guardando = false;
        _error = f.mensaje;
      }),
      (_) {
        ref.invalidate(usuariosProvider);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.usuarioNuevo,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: S.usuarioNombre),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? S.usuarioErrorNombre : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: S.usuarioCorreo),
              validator: (v) =>
                  RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch((v ?? '').trim())
                      ? null
                      : S.usuarioErrorCorreo,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<RolUsuario>(
              value: _rol,
              decoration: const InputDecoration(labelText: S.usuarioRol),
              items: const [
                DropdownMenuItem(
                    value: RolUsuario.operario,
                    child: Text(S.usuarioRolOperario)),
                DropdownMenuItem(
                    value: RolUsuario.gerencial,
                    child: Text(S.usuarioRolGerencial)),
              ],
              onChanged: (v) => setState(() => _rol = v ?? RolUsuario.operario),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passCtrl,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: S.usuarioPasswordInicial),
              validator: (v) =>
                  (v ?? '').length < 6 ? S.usuarioErrorPassword : null,
            ),
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
                  : const Text(S.usuarioGuardar),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
