import 'package:supabase_flutter/supabase_flutter.dart';

import '../local/inventario_local_mapper.dart';
import '../local/isar_service.dart';
import '../models/dosis_dto.dart';
import '../models/insumo_dto.dart';
import 'supabase_types.dart';

/// Mantiene la caché local (Isar) de insumos y recetas de dosis para habilitar
/// el descuento de inventario sin conexión (HU-03.5), y suscribe el stock al
/// canal Realtime `public:insumos` para reflejar cambios en tiempo real.
class CatalogoCacheService {
  final SupabaseClient _supabase;
  final IsarService _isar;
  RealtimeChannel? _canalInsumos;

  CatalogoCacheService(this._supabase, this._isar);

  /// Descarga insumos y recetas (programa_insumo) y los guarda en Isar.
  /// Llamar cuando haya conexión (al iniciar la app y tras sincronizar).
  Future<void> prefetch() async {
    final insumosRows = await _supabase.from(Tablas.insumos).select();
    final insumos = insumosRows
        .cast<Map<String, dynamic>>()
        .map(InsumoDto.fromJson)
        .toList();

    final dosisRows =
        await _supabase.from(Tablas.programaInsumo).select(DosisDto.select);
    final dosis =
        dosisRows.cast<Map<String, dynamic>>().map(DosisDto.fromJson).toList();

    await _isar.isar.writeTxn(() async {
      for (final i in insumos) {
        await _isar.insumos.putByIndex('id', InsumoLocalMapper.fromEntity(i));
      }
      for (final d in dosis) {
        await _isar.dosis.putByIndex('id', DosisLocalMapper.fromEntity(d));
      }
    });
  }

  /// Suscribe el stock de insumos a Realtime (canal public:insumos).
  void iniciarRealtimeStock() {
    _canalInsumos?.unsubscribe();
    _canalInsumos = _supabase
        .channel('public:insumos')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: Tablas.insumos,
          callback: (payload) async {
            final record = payload.newRecord;
            if (record.isEmpty) return;
            final insumo = InsumoDto.fromJson(record);
            await _isar.isar.writeTxn(() async {
              await _isar.insumos
                  .putByIndex('id', InsumoLocalMapper.fromEntity(insumo));
            });
          },
        )
        .subscribe();
  }

  Future<void> detenerRealtime() async {
    await _canalInsumos?.unsubscribe();
    _canalInsumos = null;
  }
}
