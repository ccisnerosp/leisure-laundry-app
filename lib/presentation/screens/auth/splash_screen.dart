import 'package:flutter/material.dart';

import '../../../core/l10n/strings_es.dart';

/// Pantalla mostrada mientras se verifica la sesión persistida (HU-01.3).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.local_laundry_service, size: 72),
            SizedBox(height: 16),
            Text(S.appNombre, style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
