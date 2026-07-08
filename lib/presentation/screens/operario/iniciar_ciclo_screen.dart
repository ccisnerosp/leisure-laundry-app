import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/strings_es.dart';
import '../../../domain/entities/cliente.dart';
import '../../../domain/entities/programa.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalogo_providers.dart';
import '../../providers/ciclo_providers.dart';
import '../../widgets/estado_views.dart';

/// HU-02.1 · Selección de programa y vinculación a cliente antes de iniciar.
class IniciarCicloScreen extends ConsumerStatefulWidget {
  const IniciarCicloScreen({super.key});

  @override
  ConsumerState<IniciarCicloScreen> createState() =>
      _IniciarCicloScreenState();
}

class _IniciarCicloScreenState extends ConsumerState<IniciarCicloScreen> {
  Programa? _programa;
  Cliente? _cliente;
  bool _iniciando = false;

  bool get _puedeConfirmar =>
      _programa != null && _cliente != null && !_iniciando;

  Future<void> _confirmar() async {
    final usuario = ref.read(usuarioActualProvider);
    if (usuario == null || _programa == null || _cliente == null) return;
    setState(() => _iniciando = true);

    await ref.read(cicloControllerProvider.notifier).iniciar(
          usuarioId: usuario.id,
          programa: _programa!,
          cliente: _cliente!,
        );
    if (!mounted) return;

    final estado = ref.read(cicloControllerProvider);
    if (estado is CicloErrorState) {
      setState(() => _iniciando = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(estado.failure.mensaje)));
    } else {
      context.pop(); // vuelve al home, que ya muestra el temporizador
    }
  }

  @override
  Widget build(BuildContext context) {
    final programasAsync = ref.watch(programasProvider(true));
    final clientesAsync = ref.watch(clientesActivosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(S.cicloIniciarTitulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Programa
            programasAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: LinearProgressIndicator(),
              ),
              error: (e, _) => ErrorView(
                mensaje: mensajeDeError(e),
                onReintentar: () => ref.invalidate(programasProvider(true)),
              ),
              data: (programas) {
                if (programas.isEmpty) {
                  return const VacioView(
                      mensaje: S.cicloSinProgramas,
                      icono: Icons.settings_suggest);
                }
                return DropdownButtonFormField<Programa>(
                  value: _programa,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: S.cicloSeleccionarPrograma,
                    prefixIcon: Icon(Icons.local_laundry_service),
                  ),
                  items: [
                    for (final p in programas)
                      DropdownMenuItem(
                        value: p,
                        child: Text('${p.nombre} · ${p.duracionMinutos} min'),
                      ),
                  ],
                  onChanged: (v) => setState(() => _programa = v),
                );
              },
            ),
            const SizedBox(height: 20),
            // Cliente
            clientesAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: LinearProgressIndicator(),
              ),
              error: (e, _) => ErrorView(
                mensaje: mensajeDeError(e),
                onReintentar: () => ref.invalidate(clientesActivosProvider),
              ),
              data: (clientes) {
                if (clientes.isEmpty) {
                  return const VacioView(
                      mensaje: S.cicloSinClientes, icono: Icons.apartment);
                }
                return DropdownButtonFormField<Cliente>(
                  value: _cliente,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: S.cicloSeleccionarCliente,
                    prefixIcon: Icon(Icons.apartment),
                  ),
                  items: [
                    for (final c in clientes)
                      DropdownMenuItem(
                        value: c,
                        child: Text(
                            '${c.nombre} · ${S.tipoClienteLabel(c.tipo.wire)}'),
                      ),
                  ],
                  onChanged: (v) => setState(() => _cliente = v),
                );
              },
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _puedeConfirmar ? _confirmar : null,
              icon: _iniciando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.play_arrow),
              label: const Text(S.cicloConfirmarInicio),
            ),
          ],
        ),
      ),
    );
  }
}
