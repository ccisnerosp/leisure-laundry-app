import 'package:flutter_test/flutter_test.dart';
import 'package:leisure/domain/entities/ciclo.dart';
import 'package:leisure/domain/entities/enums.dart';

void main() {
  Ciclo nuevo(DateTime inicio, int minutos) => Ciclo(
        id: 'c1',
        usuarioId: 'u1',
        clienteId: 'cl1',
        programaId: 'p1',
        inicioEn: inicio,
        duracionMinutos: minutos,
      );

  group('Ciclo · temporizador (OM-01)', () {
    test('finProgramado = inicio + duración', () {
      final inicio = DateTime(2026, 1, 1, 10, 0, 0);
      final c = nuevo(inicio, 40);
      expect(c.finProgramado, DateTime(2026, 1, 1, 10, 40, 0));
    });

    test('tiempoRestante decrece con el tiempo', () {
      final inicio = DateTime(2026, 1, 1, 10, 0, 0);
      final c = nuevo(inicio, 40);
      final ahora = DateTime(2026, 1, 1, 10, 10, 0); // 10 min transcurridos
      expect(c.tiempoRestante(ahora), const Duration(minutes: 30));
    });

    test('tiempoRestante nunca es negativo tras el fin', () {
      final inicio = DateTime(2026, 1, 1, 10, 0, 0);
      final c = nuevo(inicio, 40);
      final ahora = DateTime(2026, 1, 1, 11, 0, 0); // pasado el fin
      expect(c.tiempoRestante(ahora), Duration.zero);
    });

    test('estaEnCurso refleja el estado', () {
      final c = nuevo(DateTime(2026, 1, 1), 40);
      expect(c.estaEnCurso, isTrue);
      final cerrado = c.copyWith(estado: EstadoCiclo.completado);
      expect(cerrado.estaEnCurso, isFalse);
    });
  });
}
