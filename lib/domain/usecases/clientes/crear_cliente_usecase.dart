import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../../core/l10n/strings_es.dart';
import '../../entities/cliente.dart';
import '../../entities/enums.dart';
import '../../repositories/cliente_repository.dart';

/// HU-05.1 · Registra un nuevo cliente.
class CrearClienteUseCase {
  final ClienteRepository _repo;
  const CrearClienteUseCase(this._repo);

  Future<Either<Failure, Cliente>> call({
    required String nombre,
    required TipoCliente tipo,
    String? contacto,
    String? zona,
  }) {
    if (nombre.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure(S.clienteErrorNombre)));
    }
    return _repo.crear(
      nombre: nombre.trim(),
      tipo: tipo,
      contacto: contacto?.trim(),
      zona: zona?.trim(),
    );
  }
}
