import 'package:flutter/material.dart';

/// Design system de la app. Define paleta, tipografía y tamaños mínimos
/// táctiles (48x48 dp) pensados para uso en planta con guantes (HU-06.2).
abstract class AppTheme {
  static const Color _seed = Color(0xFF0B6E99); // azul "agua" lavandería
  static const double minTouchTarget = 48.0;

  // Colores semánticos de estado de stock (se usan a fondo desde Sprint 3,
  // pero el design system los define desde el Sprint 1).
  static const Color stockNormal = Color(0xFF2E7D32);
  static const Color stockBajo = Color(0xFFF9A825);
  static const Color stockCritico = Color(0xFFC62828);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Botones grandes y cómodos para uso en planta.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
      ),
      listTileTheme: const ListTileThemeData(
        minVerticalPadding: 12,
      ),
    );
  }
}
