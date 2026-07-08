import 'package:flutter/material.dart';

import '../../../../core/l10n/strings_es.dart';
import '../../../../core/utils/formato.dart';
import '../../../../domain/entities/ciclo.dart';

/// Muestra el temporizador del ciclo en curso en formato HH:MM:SS (HU-02.2).
class TemporizadorCard extends StatelessWidget {
  final Ciclo ciclo;
  final Duration restante;
  const TemporizadorCard({
    super.key,
    required this.ciclo,
    required this.restante,
  });

  @override
  Widget build(BuildContext context) {
    final total = Duration(minutes: ciclo.duracionMinutos);
    final progreso = total.inSeconds == 0
        ? 0.0
        : (1 - restante.inSeconds / total.inSeconds).clamp(0.0, 1.0);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.cicloEnCurso,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progreso,
                      strokeWidth: 10,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(S.cicloTiempoRestante,
                          style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        Formato.hms(restante),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontFeatures: const [],
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _Info(label: S.cicloPrograma, valor: ciclo.programaNombre ?? '—'),
            _Info(label: S.cicloCliente, valor: ciclo.clienteNombre ?? '—'),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String valor;
  const _Info({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(valor),
        ],
      ),
    );
  }
}
