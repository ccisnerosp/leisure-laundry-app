import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/ciclo.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/estado_inventario_item.dart';
import '../../domain/entities/indicador_turno.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/ciclo_dto.dart';
import '../models/dashboard_dto.dart';
import '../remote/supabase_types.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final SupabaseClient _supabase;
  const DashboardRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<IndicadorTurno>>> indicadoresTurno() async {
    try {
      final rows = await _supabase.from(Vistas.dashboardTurno).select();
      final data = rows
          .cast<Map<String, dynamic>>()
          .map(IndicadorTurnoDto.fromJson)
          .toList();
      return Right(data);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, List<EstadoInventarioItem>>> estadoInventario() async {
    try {
      final rows = await _supabase.from(Vistas.estadoInventario).select();
      final data = rows
          .cast<Map<String, dynamic>>()
          .map(EstadoInventarioDto.fromJson)
          .toList();
      return Right(data);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, List<Ciclo>>> ciclosActivos() async {
    try {
      final rows = await _supabase
          .from(Tablas.ciclos)
          .select(CicloDto.select)
          .eq(ColCiclo.estado, EstadoCiclo.enCurso.wire)
          .order(ColCiclo.inicioEn, ascending: false);
      final data =
          rows.cast<Map<String, dynamic>>().map(CicloDto.fromJson).toList();
      return Right(data);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }
}
