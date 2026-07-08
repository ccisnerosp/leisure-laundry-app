import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/repositories/dispositivo_repository.dart';
import '../remote/supabase_types.dart';

class DispositivoRepositoryImpl implements DispositivoRepository {
  final SupabaseClient _supabase;
  const DispositivoRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, void>> registrarToken({
    required String usuarioId,
    required String token,
    required String plataforma,
  }) async {
    try {
      await _supabase.from(Tablas.dispositivosPush).upsert(
        {
          ColDispositivo.usuarioId: usuarioId,
          ColDispositivo.tokenFcm: token,
          ColDispositivo.plataforma: plataforma,
          ColDispositivo.activo: true,
        },
        onConflict: ColDispositivo.tokenFcm,
      );
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
