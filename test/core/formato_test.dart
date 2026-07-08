import 'package:flutter_test/flutter_test.dart';
import 'package:leisure/core/utils/formato.dart';

void main() {
  group('Formato.hms', () {
    test('formatea cero como 00:00:00', () {
      expect(Formato.hms(Duration.zero), '00:00:00');
    });

    test('formatea 40 minutos como 00:40:00', () {
      expect(Formato.hms(const Duration(minutes: 40)), '00:40:00');
    });

    test('formatea 1h 2m 3s como 01:02:03', () {
      expect(
        Formato.hms(const Duration(hours: 1, minutes: 2, seconds: 3)),
        '01:02:03',
      );
    });
  });
}
