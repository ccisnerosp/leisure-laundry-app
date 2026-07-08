import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/strings_es.dart';
import '../../../../domain/entities/insumo.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/catalogo_providers.dart';
import '../../../providers/inventario_providers.dart';
import '../../../providers/usecase_providers.dart';
import '../../../widgets/estado_views.dart';

/// HU-03.3 · Formulario para registrar el ingreso de un insumo.
class RegistrarIngresoSheet extends ConsumerStatefulWidget {
  const RegistrarIngresoSheet({super.key});

  @override
  ConsumerState<RegistrarIngresoSheet> createState() =>
      _RegistrarIngresoSheetState();
}

class _RegistrarIngresoSheetState extends ConsumerState<RegistrarIngresoSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cantidadCtrl = TextEditingController();
  Insumo? _insumo;
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _cantidadCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_insumo == null) {
      setState(() => _error = S.ingresoErrorInsumo);
      return;
    }
    final usuario = ref.read(usuarioActualProvider);
    if (usuario == null) return;

    setState(() {
      _guardando = true;
      _error = null;
    });
    final res = await ref.read(registrarIngresoUseCaseProvider).call(
          insumoId: _insumo!.id,
          cantidad: double.parse(_cantidadCtrl.text.trim()),
          usuarioId: usuario.id,
        );
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _guardando = false;
        _error = f.mensaje;
      }),
      (_) {
        ref.invalidate(insumosProvider);
        ref.invalidate(historialProvider);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(S.ingresoOk)));
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
            Text(S.ingresoTitulo,
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
                decoration: const InputDecoration(labelText: S.ingresoInsumo),
                items: [
                  for (final i in insumos)
                    DropdownMenuItem(value: i, child: Text(i.nombre)),
                ],
                onChanged: (v) => setState(() => _insumo = v),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cantidadCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: S.ingresoCantidad),
              validator: (v) {
                final n = double.tryParse((v ?? '').trim());
                if (n == null || n <= 0) return S.ingresoErrorCantidad;
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
                  : const Text(S.ingresoGuardar),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
