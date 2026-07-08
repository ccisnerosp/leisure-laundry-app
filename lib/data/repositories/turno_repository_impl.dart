import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/turno.dart';
import '../../domain/repositories/turno_repository.dart';
import '../models/turno_dto.dart';
import '../remote/supabase_types.dart';

class TurnoRepositoryImpl implements TurnoRepository {
  final SupabaseClient _supabase;
  const TurnoRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<Turno>>> listarActivos() async {
    try {
      final rows = await _supabase
          .from(Tablas.turnos)
          .select()
          .eq(ColTurno.activo, true)
          .order(ColTurno.horaInicio);
      final turnos =
          rows.cast<Map<String, dynamic>>().map(TurnoDto.fromJson).toList();
      return Right(turnos);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }
}
