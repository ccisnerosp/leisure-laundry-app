import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/dosis_programa.dart';
import '../../domain/repositories/dosis_repository.dart';
import '../local/inventario_local_mapper.dart';
import '../local/isar_service.dart';
import '../models/dosis_dto.dart';
import '../remote/supabase_types.dart';

class DosisRepositoryImpl implements DosisRepository {
  final SupabaseClient _supabase;
  final IsarService _isar;
  const DosisRepositoryImpl(this._supabase, this._isar);

  @override
  Future<Either<Failure, List<DosisPrograma>>> listarPorPrograma(
      String programaId) async {
    try {
      final rows = await _supabase
          .from(Tablas.programaInsumo)
          .select(DosisDto.select)
          .eq(ColProgramaInsumo.programaId, programaId);
      final dosis =
          rows.cast<Map<String, dynamic>>().map(DosisDto.fromJson).toList();
      await _cachear(dosis);
      return Right(dosis);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, DosisPrograma>> guardar({
    required String programaId,
    required String insumoId,
    required double dosis,
  }) async {
    try {
      final row = await _supabase
          .from(Tablas.programaInsumo)
          .upsert(
            {
              ColProgramaInsumo.programaId: programaId,
              ColProgramaInsumo.insumoId: insumoId,
              ColProgramaInsumo.dosis: dosis,
            },
            onConflict: '${ColProgramaInsumo.programaId},${ColProgramaInsumo.insumoId}',
          )
          .select(DosisDto.select)
          .single();
      final guardada = DosisDto.fromJson(row);
      await _cachear([guardada]);
      return Right(guardada);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, void>> eliminar(String dosisId) async {
    try {
      await _supabase
          .from(Tablas.programaInsumo)
          .delete()
          .eq(ColProgramaInsumo.id, dosisId);
      await _isar.isar.writeTxn(() async {
        await _isar.dosis.deleteByIndex('id', [dosisId]);
      });
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  Future<void> _cachear(List<DosisPrograma> dosis) async {
    await _isar.isar.writeTxn(() async {
      for (final d in dosis) {
        await _isar.dosis.putByIndex('id', DosisLocalMapper.fromEntity(d));
      }
    });
  }
}
