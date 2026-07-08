import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/strings_es.dart';
import '../providers/sync_providers.dart';

/// Banner persistente de "Modo sin conexión" (HU-02.5). Aparece cuando no hay
/// conexión y se oculta automáticamente al recuperarla. También muestra el
/// estado de sincronización al reconectar.
class ConexionBanner extends ConsumerWidget {
  const ConexionBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncControllerProvider);

    if (sync.online && !sync.sincronizando && sync.pendientes == 0) {
      return const SizedBox.shrink();
    }

    final cs = Theme.of(context).colorScheme;
    final (color, icono, texto) = !sync.online
        ? (cs.errorContainer, Icons.cloud_off, S.modoOffline)
        : sync.sincronizando
            ? (cs.tertiaryContainer, Icons.sync, S.sincronizando)
            : (cs.tertiaryContainer, Icons.cloud_upload,
                S.pendientesSync(sync.pendientes));

    return Material(
      color: color,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(icono, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(texto)),
              if (sync.online && !sync.sincronizando && sync.pendientes > 0)
                TextButton(
                  onPressed: () =>
                      ref.read(syncControllerProvider.notifier).sincronizarAhora(),
                  child: const Text('Sincronizar'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
