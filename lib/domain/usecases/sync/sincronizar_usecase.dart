import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../repositories/sync_repository.dart';

/// HU-02.5 / HU-03.5 · Sincroniza los registros locales pendientes con Supabase.
class SincronizarUseCase {
  final SyncRepository _repo;
  const SincronizarUseCase(this._repo);

  Future<Either<Failure, SyncResultado>> call() => _repo.sincronizar();

  Future<int> pendientes() => _repo.pendientes();
}
