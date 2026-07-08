import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../../core/l10n/strings_es.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../models/usuario_dto.dart';
import '../remote/supabase_types.dart';

/// Gestión de usuarios (HU-05.3).
///
/// La creación de un usuario requiere crear también su credencial en Supabase
/// Auth, lo cual solo puede hacerse con la `service_role` key. Por seguridad,
/// esa clave NUNCA va en el cliente: la creación se delega a la Edge Function
/// `crear-operario` (ver `supabase/functions/crear-operario/`), que crea el
/// auth user y la fila en `usuarios` de forma atómica y devuelve el perfil.
class UsuarioRepositoryImpl implements UsuarioRepository {
  final SupabaseClient _supabase;
  const UsuarioRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<Usuario>>> listar() async {
    try {
      final rows = await _supabase
          .from(Tablas.usuarios)
          .select()
          .order(ColUsuario.nombre);
      final usuarios =
          rows.cast<Map<String, dynamic>>().map(UsuarioDto.fromJson).toList();
      return Right(usuarios);
    } catch (_) {
      return const Left(ServerFailure(S.errorCargandoDatos));
    }
  }

  @override
  Future<Either<Failure, Usuario>> crear({
    required String nombre,
    required String email,
    required RolUsuario rol,
    required String passwordInicial,
  }) async {
    try {
      final res = await _supabase.functions.invoke(
        'crear-operario',
        body: {
          'nombre': nombre,
          'email': email,
          'rol': rol.wire,
          'password': passwordInicial,
        },
      );
      final data = res.data;
      if (data is Map && data['usuario'] is Map) {
        return Right(
            UsuarioDto.fromJson((data['usuario'] as Map).cast<String, dynamic>()));
      }
      return const Left(ServerFailure(
          'No se pudo crear el usuario. Verifica que la función "crear-operario" esté desplegada.'));
    } on FunctionException {
      return const Left(ServerFailure(
          'No se pudo crear el usuario. Revisa el correo (¿ya existe?) y la función "crear-operario".'));
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }

  @override
  Future<Either<Failure, void>> cambiarEstado(String id,
      {required bool activo}) async {
    try {
      await _supabase
          .from(Tablas.usuarios)
          .update({ColUsuario.activo: activo}).eq(ColUsuario.id, id);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure(S.errorServidor));
    }
  }
}
