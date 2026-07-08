import 'package:flutter_test/flutter_test.dart';
import 'package:leisure/core/error/either.dart';
import 'package:leisure/core/error/failure.dart';
import 'package:leisure/domain/entities/enums.dart';
import 'package:leisure/domain/entities/insumo.dart';
import 'package:leisure/domain/repositories/cliente_repository.dart';
import 'package:leisure/domain/repositories/dosis_repository.dart';
import 'package:leisure/domain/repositories/insumo_repository.dart';
import 'package:leisure/domain/repositories/sync_repository.dart';
import 'package:leisure/domain/usecases/clientes/crear_cliente_usecase.dart';
import 'package:leisure/domain/usecases/inventario/guardar_dosis_usecase.dart';
import 'package:leisure/domain/usecases/inventario/registrar_ingreso_usecase.dart';
import 'package:leisure/domain/usecases/sync/sincronizar_usecase.dart';

// --- Fakes mínimos ---

class _OkSyncRepository implements SyncRepository {
  @override
  Future<int> pendientes() async => 5;
  @override
  Future<Either<Failure, SyncResultado>> sincronizar() async =>
      const Right(SyncResultado(ciclosSincronizados: 3, movimientosSincronizados: 4));
}

void main() {
  group('Insumo.estadoStock (clasificación de inventario)', () {
    Insumo insumo(double stock, double umbral) => Insumo(
          id: 'i', nombre: 'Detergente', unidad: UnidadInsumo.ml,
          stockActual: stock, umbralMinimo: umbral,
        );

    test('crítico cuando stock <= umbral', () {
      expect(insumo(100, 100).estadoStock, EstadoStock.critico);
      expect(insumo(80, 100).estadoStock, EstadoStock.critico);
    });
    test('bajo cuando stock <= umbral * 1.5', () {
      expect(insumo(140, 100).estadoStock, EstadoStock.bajo);
    });
    test('normal cuando stock alto', () {
      expect(insumo(500, 100).estadoStock, EstadoStock.normal);
    });
  });

  group('Validaciones de casos de uso (Sprint 2)', () {
    test('CrearClienteUseCase rechaza nombre vacío', () async {
      final uc = CrearClienteUseCase(_NoopClienteRepo());
      final res = await uc(nombre: '   ', tipo: TipoCliente.hotel);
      expect(res.isLeft, isTrue);
      expect(res.leftOrNull, isA<ValidationFailure>());
    });

    test('RegistrarIngresoUseCase rechaza cantidad <= 0', () async {
      final uc = RegistrarIngresoUseCase(_NoopInsumoRepo());
      final res = await uc(insumoId: 'i', cantidad: 0, usuarioId: 'u');
      expect(res.leftOrNull, isA<ValidationFailure>());
    });

    test('GuardarDosisUseCase rechaza dosis <= 0', () async {
      final uc = GuardarDosisUseCase(_NoopDosisRepo());
      final res = await uc(programaId: 'p', insumoId: 'i', dosis: 0);
      expect(res.leftOrNull, isA<ValidationFailure>());
    });
  });

  group('SincronizarUseCase (HU-02.5 / HU-03.5)', () {
    test('devuelve el total de registros sincronizados', () async {
      final uc = SincronizarUseCase(_OkSyncRepository());
      final res = await uc();
      expect(res.isRight, isTrue);
      expect(res.rightOrNull?.ciclosSincronizados, 3);
      expect(res.rightOrNull?.movimientosSincronizados, 4);
      expect(res.rightOrNull?.total, 7);
    });

    test('expone los registros pendientes', () async {
      final uc = SincronizarUseCase(_OkSyncRepository());
      expect(await uc.pendientes(), 5);
    });
  });
}

// Repos noop: los casos de uso fallan en validación antes de tocar el repo,
// por lo que sus métodos no llegan a invocarse.
class _NoopClienteRepo implements ClienteRepository {
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

class _NoopInsumoRepo implements InsumoRepository {
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

class _NoopDosisRepo implements DosisRepository {
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}
