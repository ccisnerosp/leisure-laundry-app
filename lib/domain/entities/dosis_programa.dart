/// Dosis de un insumo consumida por un programa (tabla `programa_insumo`).
/// Es la "receta" que el descuento automático aplica al iniciar un ciclo
/// (HU-03.2 / OM-02).
class DosisPrograma {
  final String id;
  final String programaId;
  final String insumoId;
  final double dosis;

  // Desnormalizado para presentación.
  final String? insumoNombre;
  final String? insumoUnidad;

  const DosisPrograma({
    required this.id,
    required this.programaId,
    required this.insumoId,
    required this.dosis,
    this.insumoNombre,
    this.insumoUnidad,
  });
}
