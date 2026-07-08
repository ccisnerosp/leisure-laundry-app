import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/programa.dart';
import '../../repositories/programa_repository.dart';

/// HU-05.2 / HU-02.1 · Lista programas (todos para gerencial, solo activos para
/// el operario que va a iniciar un ciclo).
class ListarProgramasUseCase {
  final ProgramaRepository _repo;
  const ListarProgramasUseCase(this._repo);

  Future<Either<Failure, List<Programa>>> call({bool soloActivos = false}) =>
      _repo.listar(soloActivos: soloActivos);
}
