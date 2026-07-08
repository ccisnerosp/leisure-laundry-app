import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/strings_es.dart';
import '../../../../domain/entities/ciclo.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ciclo_providers.dart';

/// HU-02.3/02.4 · Alerta visual a pantalla completa al término del ciclo.
/// La única forma de silenciar la alarma es confirmar el retiro de prendas.
class CicloFinalizadoView extends ConsumerStatefulWidget {
  final Ciclo ciclo;
  const CicloFinalizadoView({super.key, required this.ciclo});

  @override
  ConsumerState<CicloFinalizadoView> createState() =>
      _CicloFinalizadoViewState();
}

class _CicloFinalizadoViewState extends ConsumerState<CicloFinalizadoView> {
  bool _procesando = false;

  Future<void> _confirmar() async {
    setState(() => _procesando = true);
    final failure =
        await ref.read(cicloControllerProvider.notifier).confirmarRetiro();
    if (!mounted) return;
    if (failure != null) {
      setState(() => _procesando = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failure.mensaje)));
    } else {
      // Refresca el historial con el ciclo recién completado.
      final u = ref.read(usuarioActualProvider);
      if (u != null) ref.invalidate(ciclosUsuarioProvider(u.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: cs.errorContainer,
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications_active,
                  size: 96, color: cs.onErrorContainer),
              const SizedBox(height: 24),
              Text(
                S.cicloFinalizado,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: cs.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                S.cicloRetirarMensaje,
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onErrorContainer),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.ciclo.programaNombre ?? ''} · ${widget.ciclo.clienteNombre ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: cs.onErrorContainer,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _procesando ? null : _confirmar,
                  icon: _procesando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.checkroom),
                  label: const Text(S.cicloRetirePrendas),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
