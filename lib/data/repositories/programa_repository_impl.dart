import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/programa.dart';
import '../../domain/repositories/programa_repository.dart';
import '../models/programa_dto.dart';
import '../remote/supabase_types.dart';

class ProgramaRepositoryImpl implements ProgramaRepository {
  final SupabaseClient _supabase;
  const ProgramaRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<Programa>>> listar({bool soloActivos = false}) async {
    try {
      var query = _supabase.from(Tablas.programas).select();
      if (soloActivos) {
        query = query.eq(ColPrograma.activo, true);
      }
      final rows = await query.order(ColPrograma.nombre);
      final programas = rows
          .cast<Map<String, dynamic>>()
          .map(ProgramaDto.fromJson)
          .toList();
      return Right(programas);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, Programa>> crear({
    required String nombre,
    required TipoPrograma tipo,
    required int duracionMinutos,
  }) async {
    try {
      final row = await _supabase
          .from(Tablas.programas)
          .insert(ProgramaDto.toInsert(
            nombre: nombre,
            tipo: tipo,
            duracionMinutos: duracionMinutos,
          ))
          .select()
          .single();
      return Right(ProgramaDto.fromJson(row));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, Programa>> actualizar(Programa programa) async {
    try {
      final row = await _supabase
          .from(Tablas.programas)
          .update(ProgramaDto.toUpdate(programa))
          .eq(ColPrograma.id, programa.id)
          .select()
          .single();
      return Right(ProgramaDto.fromJson(row));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, void>> cambiarEstado(String id,
      {required bool activo}) async {
    try {
      await _supabase
          .from(Tablas.programas)
          .update({ColPrograma.activo: activo}).eq(ColPrograma.id, id);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
