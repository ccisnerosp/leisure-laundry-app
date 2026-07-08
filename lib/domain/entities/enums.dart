// Enums del dominio. Los valores `wire` corresponden exactamente a los tipos
// ENUM del esquema PostgreSQL/Supabase (`leisure_db_schema.sql`).

enum RolUsuario {
  operario('operario'),
  gerencial('gerencial');

  final String wire;
  const RolUsuario(this.wire);

  static RolUsuario fromWire(String value) =>
      RolUsuario.values.firstWhere((e) => e.wire == value);
}

enum TipoCliente {
  hotel('hotel'),
  airbnb('airbnb'),
  otro('otro');

  final String wire;
  const TipoCliente(this.wire);

  static TipoCliente fromWire(String value) =>
      TipoCliente.values.firstWhere((e) => e.wire == value);
}

enum TipoPrograma {
  lavado('lavado'),
  secado('secado');

  final String wire;
  const TipoPrograma(this.wire);

  static TipoPrograma fromWire(String value) =>
      TipoPrograma.values.firstWhere((e) => e.wire == value);
}

enum EstadoCiclo {
  enCurso('en_curso'),
  completado('completado'),
  cancelado('cancelado');

  final String wire;
  const EstadoCiclo(this.wire);

  static EstadoCiclo fromWire(String value) =>
      EstadoCiclo.values.firstWhere((e) => e.wire == value);
}

enum UnidadInsumo {
  ml('ml'),
  g('g'),
  unidad('unidad');

  final String wire;
  const UnidadInsumo(this.wire);

  static UnidadInsumo fromWire(String value) =>
      UnidadInsumo.values.firstWhere((e) => e.wire == value);
}

enum TipoMovimiento {
  descuento('descuento'),
  ingreso('ingreso'),
  ajuste('ajuste');

  final String wire;
  const TipoMovimiento(this.wire);

  static TipoMovimiento fromWire(String value) =>
      TipoMovimiento.values.firstWhere((e) => e.wire == value);
}
