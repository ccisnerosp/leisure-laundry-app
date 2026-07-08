import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leisure/core/theme/app_theme.dart';

/// HU-06.2 · Verifica que los elementos táctiles cumplan el tamaño mínimo de
/// 48x48 dp usando WidgetTester, aplicando el tema de la app.
void main() {
  testWidgets('Los botones del tema miden al menos 48x48 dp', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () {},
            child: const Text('Aceptar'),
          ),
        ),
      ),
    ));

    final size = tester.getSize(find.byType(FilledButton));
    expect(size.height, greaterThanOrEqualTo(AppTheme.minTouchTarget));
    expect(size.width, greaterThanOrEqualTo(AppTheme.minTouchTarget));
  });

  testWidgets('Los IconButton miden al menos 48x48 dp', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ),
      ),
    ));

    final size = tester.getSize(find.byType(IconButton));
    expect(size.height, greaterThanOrEqualTo(48.0));
    expect(size.width, greaterThanOrEqualTo(48.0));
  });

  test('El design system define el mínimo táctil en 48 dp', () {
    expect(AppTheme.minTouchTarget, 48.0);
  });
}
