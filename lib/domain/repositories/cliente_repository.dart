import '../../core/error/either.dart';
import '../../core/error/failure.dart';
import '../entities/cliente.dart';
import '../entities/enums.dart';

/// Contrato de catálogo de clientes. El CRUD completo se incorpora en Sprint 2
/// (HU-05.1); el listado ya existía desde Sprint 1 (HU-02.1).
abstract interface class ClienteRepository {
  Future<Either<Failure, List<Cliente>>> listar({bool soloActivos = false});

  Future<Either<Failure, Cliente>> crear({
    required String nombre,
    required TipoCliente tipo,
    String? contacto,
    String? zona,
  });

  Future<Either<Failure, Cliente>> actualizar(Cliente cliente);

  /// Activa/desactiva un cliente (lo oculta de las listas sin borrar historial).
  Future<Either<Failure, void>> cambiarEstado(String id, {required bool activo});
}
