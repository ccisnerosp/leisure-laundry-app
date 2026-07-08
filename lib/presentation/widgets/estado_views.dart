import 'package:flutter/material.dart';

import '../../core/l10n/strings_es.dart';

/// Vista de carga centrada.
class CargandoView extends StatelessWidget {
  const CargandoView({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

/// Vista de error con opción de reintentar.
class ErrorView extends StatelessWidget {
  final String mensaje;
  final VoidCallback? onReintentar;
  const ErrorView({super.key, required this.mensaje, this.onReintentar});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(mensaje, textAlign: TextAlign.center),
            if (onReintentar != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onReintentar,
                icon: const Icon(Icons.refresh),
                label: const Text(S.reintentar),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Vista de lista vacía.
class VacioView extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  const VacioView({super.key, required this.mensaje, this.icono = Icons.inbox});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 48, color: Theme.of(context).disabledColor),
            const SizedBox(height: 12),
            Text(mensaje, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
