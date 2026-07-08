import '../../../core/error/either.dart';
import '../../../core/error/failure.dart';
import '../../entities/dosis_programa.dart';
import '../../repositories/dosis_repository.dart';

/// HU-03.2 · Lista las dosis configuradas para un programa.
class ListarDosisUseCase {
  final DosisRepository _repo;
  const ListarDosisUseCase(this._repo);

  Future<Either<Failure, List<DosisPrograma>>> call(String programaId) =>
      _repo.listarPorPrograma(programaId);
}
