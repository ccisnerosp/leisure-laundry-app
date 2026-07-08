import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/entities/enums.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../models/cliente_dto.dart';
import '../remote/supabase_types.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final SupabaseClient _supabase;
  const ClienteRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<Cliente>>> listar({bool soloActivos = false}) async {
    try {
      var query = _supabase.from(Tablas.clientes).select();
      if (soloActivos) {
        query = query.eq(ColCliente.activo, true);
      }
      final rows = await query.order(ColCliente.nombre);
      final clientes =
          rows.cast<Map<String, dynamic>>().map(ClienteDto.fromJson).toList();
      return Right(clientes);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, Cliente>> crear({
    required String nombre,
    required TipoCliente tipo,
    String? contacto,
    String? zona,
  }) async {
    try {
      final row = await _supabase
          .from(Tablas.clientes)
          .insert(ClienteDto.toInsert(
            nombre: nombre,
            tipo: tipo,
            contacto: contacto,
            zona: zona,
          ))
          .select()
          .single();
      return Right(ClienteDto.fromJson(row));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, Cliente>> actualizar(Cliente cliente) async {
    try {
      final row = await _supabase
          .from(Tablas.clientes)
          .update(ClienteDto.toUpdate(cliente))
          .eq(ColCliente.id, cliente.id)
          .select()
          .single();
      return Right(ClienteDto.fromJson(row));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, void>> cambiarEstado(String id,
      {required bool activo}) async {
    try {
      await _supabase
          .from(Tablas.clientes)
          .update({ColCliente.activo: activo}).eq(ColCliente.id, id);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
