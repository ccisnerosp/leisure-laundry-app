import 'package:flutter_test/flutter_test.dart';
import 'package:leisure/core/error/either.dart';
import 'package:leisure/core/error/failure.dart';
import 'package:leisure/domain/entities/ciclo.dart';
import 'package:leisure/domain/entities/cliente.dart';
import 'package:leisure/domain/entities/enums.dart';
import 'package:leisure/domain/entities/programa.dart';
import 'package:leisure/domain/entities/turno.dart';
import 'package:leisure/domain/repositories/ciclo_repository.dart';
import 'package:leisure/domain/repositories/turno_repository.dart';
import 'package:leisure/domain/usecases/ciclos/cerrar_ciclo_usecase.dart';
import 'package:leisure/domain/usecases/ciclos/iniciar_ciclo_usecase.dart';

/// Fake de CicloRepository que captura los argumentos del último `iniciar`.
class FakeCicloRepository implements CicloRepository {
  String? turnoIdRecibido;
  bool iniciarLlamado = false;
  bool cerrarLlamado = false;

  @override
  Future<Either<Failure, Ciclo>> iniciar({
    required String usuarioId,
    required String clienteId,
    required String programaId,
    required String? turnoId,
    required int duracionMinutos,
    String? programaNombre,
    String? clienteNombre,
  }) async {
    iniciarLlamado = true;
    turnoIdRecibido = turnoId;
    return Right(Ciclo(
      id: 'nuevo',
      usuarioId: usuarioId,
      clienteId: clienteId,
      programaId: programaId,
      turnoId: turnoId,
      inicioEn: DateTime(2026, 1, 1, 8, 0),
      duracionMinutos: duracionMinutos,
      programaNombre: programaNombre,
      clienteNombre: clienteNombre,
    ));
  }

  @override
  Future<Either<Failure, Ciclo>> cerrar(String cicloId) async {
    cerrarLlamado = true;
    return Right(Ciclo(
      id: cicloId,
      usuarioId: 'u1',
      clienteId: 'cl1',
      programaId: 'p1',
      inicioEn: DateTime(2026, 1, 1, 8, 0),
      finEn: DateTime(2026, 1, 1, 8, 40),
      estado: EstadoCiclo.completado,
    ));
  }

  @override
  Future<Either<Failure, List<Ciclo>>> listarPorUsuario(String usuarioId) async =>
      const Right([]);

  @override
  Future<Either<Failure, Ciclo?>> cicloEnCurso(String usuarioId) async =>
      const Right(null);
}

class FakeTurnoRepository implements TurnoRepository {
  final List<Turno> turnos;
  FakeTurnoRepository(this.turnos);

  @override
  Future<Either<Failure, List<Turno>>> listarActivos() async => Right(turnos);
}

void main() {
  final programaActivo = const Programa(
    id: 'p1',
    nombre: 'Lavado rápido',
    tipo: TipoPrograma.lavado,
    duracionMinutos: 40,
  );
  final clienteActivo = const Cliente(
    id: 'cl1',
    nombre: 'Hotel Sol',
    tipo: TipoCliente.hotel,
  );
  // Turno mañana 06:00-14:00.
  final turnoManana = Turno(
    id: 't-manana',
    nombre: 'Turno mañana',
    horaInicioMin: 6 * 60,
    horaFinMin: 14 * 60,
  );

  group('IniciarCicloUseCase (HU-02.2)', () {
    test('rechaza programa inactivo', () async {
      final uc = IniciarCicloUseCase(
          FakeCicloRepository(), FakeTurnoRepository([turnoManana]));
      final res = await uc(
        usuarioId: 'u1',
        programa: programaActivo.copyWith(activo: false),
        cliente: clienteActivo,
      );
      expect(res.isLeft, isTrue);
      expect(res.leftOrNull, isA<ValidationFailure>());
    });

    test('rechaza cliente inactivo', () async {
      final uc = IniciarCicloUseCase(
          FakeCicloRepository(), FakeTurnoRepository([turnoManana]));
      final res = await uc(
        usuarioId: 'u1',
        programa: programaActivo,
        cliente: clienteActivo.copyWith(activo: false),
      );
      expect(res.isLeft, isTrue);
    });

    test('asigna el turno que contiene la hora de inicio', () async {
      final repo = FakeCicloRepository();
      final uc = IniciarCicloUseCase(repo, FakeTurnoRepository([turnoManana]));
      final res = await uc(
        usuarioId: 'u1',
        programa: programaActivo,
        cliente: clienteActivo,
        ahora: DateTime(2026, 1, 1, 9, 0), // 09:00 → turno mañana
      );
      expect(res.isRight, isTrue);
      expect(repo.turnoIdRecibido, 't-manana');
    });

    test('deja turno nulo cuando ninguno contiene la hora', () async {
      final repo = FakeCicloRepository();
      final uc = IniciarCicloUseCase(repo, FakeTurnoRepository([turnoManana]));
      final res = await uc(
        usuarioId: 'u1',
        programa: programaActivo,
        cliente: clienteActivo,
        ahora: DateTime(2026, 1, 1, 23, 0), // 23:00 → sin turno
      );
      expect(res.isRight, isTrue);
      expect(repo.turnoIdRecibido, isNull);
    });

    test('propaga la duración del programa al ciclo', () async {
      final repo = FakeCicloRepository();
      final uc = IniciarCicloUseCase(repo, FakeTurnoRepository([turnoManana]));
      final res = await uc(
        usuarioId: 'u1',
        programa: programaActivo,
        cliente: clienteActivo,
        ahora: DateTime(2026, 1, 1, 9, 0),
      );
      expect(res.rightOrNull?.duracionMinutos, 40);
    });
  });

  group('CerrarCicloUseCase (HU-02.4)', () {
    test('cierra el ciclo y lo marca completado', () async {
      final repo = FakeCicloRepository();
      final uc = CerrarCicloUseCase(repo);
      final res = await uc('nuevo');
      expect(repo.cerrarLlamado, isTrue);
      expect(res.rightOrNull?.estado, EstadoCiclo.completado);
      expect(res.rightOrNull?.finEn, isNotNull);
    });
  });
}
