import 'package:audioplayers/audioplayers.dart';

/// Reproduce el sonido de alarma en bucle cuando un ciclo termina y la app está
/// en primer plano (complementa la notificación local) (HU-02.3).
///
/// El audio se reproduce desde `assets/sounds/alarma.mp3`. Si el archivo no
/// está presente, falla silenciosamente y se confía en el sonido de la
/// notificación del sistema operativo.
class AlarmaService {
  final AudioPlayer _player = AudioPlayer();
  static const _asset = 'sounds/alarma.mp3';

  Future<void> iniciar() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource(_asset));
    } catch (_) {
      // Sin asset de audio: la alerta sonora la cubre la notificación del SO.
    }
  }

  Future<void> detener() async {
    try {
      await _player.stop();
    } catch (_) {}
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
