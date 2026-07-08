import '../../core/error/either.dart';
import '../../core/error/failure.dart';

/// Resultado de una sincronización: cuántos registros locales se replicaron.
class SyncResultado {
  final int ciclosSincronizados;
  final int movimientosSincronizados;
  const SyncResultado({
    this.ciclosSincronizados = 0,
    this.movimientosSincronizados = 0,
  });

  int get total => ciclosSincronizados + movimientosSincronizados;
}

/// Contrato de sincronización bidireccional offline → servidor (HU-02.5/03.5).
abstract interface class SyncRepository {
  /// Cuántos registros locales están pendientes de sincronizar.
  Future<int> pendientes();

  /// Sube a Supabase, en orden, los ciclos y luego los movimientos con
  /// `sincronizado = false`. Resuelve conflictos por timestamp (el más reciente
  /// gana). Idempotente.
  Future<Either<Failure, SyncResultado>> sincronizar();
}
