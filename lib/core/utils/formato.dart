/// Utilidades de formato de presentación.
abstract class Formato {
  /// Formatea una duración como HH:MM:SS (HU-02.2).
  static String hms(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  /// Cantidad numérica sin ceros decimales innecesarios (p. ej. 1000, 12.5).
  static String cantidad(double n) {
    if (n == n.roundToDouble()) return n.toInt().toString();
    return n.toStringAsFixed(2);
  }

  /// Fecha y hora local legible: dd/MM/yyyy HH:mm.
  static String fechaHora(DateTime dt) {
    final l = dt.toLocal();
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${dos(l.day)}/${dos(l.month)}/${l.year} ${dos(l.hour)}:${dos(l.minute)}';
  }
}
