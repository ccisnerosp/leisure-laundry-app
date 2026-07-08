import 'enums.dart';

/// Cliente B2B (hotel o Airbnb) que se vincula a cada ciclo (tabla `clientes`).
class Cliente {
  final String id;
  final String nombre;
  final TipoCliente tipo;
  final String? contacto;
  final String? zona;
  final bool activo;

  const Cliente({
    required this.id,
    required this.nombre,
    required this.tipo,
    this.contacto,
    this.zona,
    this.activo = true,
  });

  Cliente copyWith({
    String? nombre,
    TipoCliente? tipo,
    String? contacto,
    String? zona,
    bool? activo,
  }) =>
      Cliente(
        id: id,
        nombre: nombre ?? this.nombre,
        tipo: tipo ?? this.tipo,
        contacto: contacto ?? this.contacto,
        zona: zona ?? this.zona,
        activo: activo ?? this.activo,
      );
}
