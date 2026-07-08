import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/strings_es.dart';
import '../../../../core/utils/formato.dart';
import '../../../../domain/entities/movimiento_inventario.dart';
import '../../../../domain/repositories/movimiento_repository.dart';
import '../../../providers/catalogo_providers.dart';
import '../../../providers/inventario_providers.dart';
import '../../../widgets/estado_views.dart';

/// HU-03.4 · Historial de consumo con filtros por insumo, fecha y turno.
class HistorialTab extends ConsumerWidget {
  const HistorialTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtro = ref.watch(filtroHistorialProvider);
    final async = ref.watch(historialProvider);
    final insumosAsync = ref.watch(insumosProvider);
    final turnosAsync = ref.watch(turnosProvider);

    void actualizar(FiltroMovimientos nuevo) =>
        ref.read(filtroHistorialProvider.notifier).state = nuevo;

    Future<void> pickFecha(bool desde) async {
      final inicial =
          (desde ? filtro.desde : filtro.hasta) ?? DateTime.now();
      final r = await showDatePicker(
        context: context,
        initialDate: inicial,
        firstDate: DateTime(2024),
        lastDate: DateTime(2100),
      );
      if (r == null) return;
      actualizar(FiltroMovimientos(
        insumoId: filtro.insumoId,
        turnoId: filtro.turnoId,
        desde: desde ? DateTime(r.year, r.month, r.day) : filtro.desde,
        hasta: desde
            ? filtro.hasta
            : DateTime(r.year, r.month, r.day, 23, 59, 59),
      ));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: insumosAsync.maybeWhen(
                      data: (insumos) => DropdownButtonFormField<String?>(
                        value: filtro.insumoId,
                        isExpanded: true,
                        decoration: const InputDecoration(
                            labelText: S.historialFiltroInsumo),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text(S.historialFiltroTodos)),
                          for (final i in insumos)
                            DropdownMenuItem(value: i.id, child: Text(i.nombre)),
                        ],
                        onChanged: (v) => actualizar(FiltroMovimientos(
                          insumoId: v,
                          turnoId: filtro.turnoId,
                          desde: filtro.desde,
                          hasta: filtro.hasta,
                        )),
                      ),
                      orElse: () => const SizedBox(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: turnosAsync.maybeWhen(
                      data: (turnos) => DropdownButtonFormField<String?>(
                        value: filtro.turnoId,
                        isExpanded: true,
                        decoration: const InputDecoration(
                            labelText: S.historialFiltroTurno),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text(S.historialFiltroTodos)),
                          for (final t in turnos)
                            DropdownMenuItem(
                                value: t.id, child: Text(t.nombre)),
                        ],
                        onChanged: (v) => actualizar(FiltroMovimientos(
                          insumoId: filtro.insumoId,
                          turnoId: v,
                          desde: filtro.desde,
                          hasta: filtro.hasta,
                        )),
                      ),
                      orElse: () => const SizedBox(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today, size: 18),
                      onPressed: () => pickFecha(true),
                      label: Text(filtro.desde == null
                          ? S.historialFiltroDesde
                          : Formato.fechaHora(filtro.desde!).split(' ').first),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.event, size: 18),
                      onPressed: () => pickFecha(false),
                      label: Text(filtro.hasta == null
                          ? S.historialFiltroHasta
                          : Formato.fechaHora(filtro.hasta!).split(' ').first),
                    ),
                  ),
                  if (filtro.insumoId != null ||
                      filtro.turnoId != null ||
                      filtro.desde != null ||
                      filtro.hasta != null)
                    IconButton(
                      tooltip: S.cancelar,
                      icon: const Icon(Icons.clear),
                      onPressed: () => actualizar(const FiltroMovimientos()),
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: async.when(
            loading: () => const CargandoView(),
            error: (e, _) => ErrorView(
              mensaje: mensajeDeError(e),
              onReintentar: () => ref.invalidate(historialProvider),
            ),
            data: (movimientos) {
              if (movimientos.isEmpty) {
                return const VacioView(
                    mensaje: S.historialSinRegistros, icono: Icons.history);
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: movimientos.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (_, i) => _MovimientoTile(mov: movimientos[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MovimientoTile extends StatelessWidget {
  final MovimientoInventario mov;
  const _MovimientoTile({required this.mov});

  @override
  Widget build(BuildContext context) {
    final esIngreso = mov.tipo.wire == 'ingreso';
    return Card(
      child: ListTile(
        leading: Icon(
          esIngreso ? Icons.arrow_downward : Icons.arrow_upward,
          color: esIngreso ? Colors.green : Theme.of(context).colorScheme.error,
        ),
        title: Text('${S.tipoMovimientoLabel(mov.tipo.wire)} · '
            '${mov.insumoNombre ?? ''}'),
        subtitle: Text(
          '${Formato.fechaHora(mov.registradoEn)}'
          '${mov.usuarioNombre != null ? ' · ${mov.usuarioNombre}' : ''}',
        ),
        trailing: Text(
          '${esIngreso ? '+' : '-'}${Formato.cantidad(mov.cantidad)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
