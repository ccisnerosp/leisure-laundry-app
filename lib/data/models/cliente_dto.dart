import '../../domain/entities/cliente.dart';
import '../../domain/entities/enums.dart';
import '../remote/supabase_types.dart';

/// Mapeo entre la fila de `clientes` y la entidad [Cliente].
class ClienteDto {
  static Cliente fromJson(Map<String, dynamic> j) => Cliente(
        id: j[ColCliente.id] as String,
        nombre: j[ColCliente.nombre] as String,
        tipo: TipoCliente.fromWire(j[ColCliente.tipo] as String),
        contacto: j[ColCliente.contacto] as String?,
        zona: j[ColCliente.zona] as String?,
        activo: (j[ColCliente.activo] as bool?) ?? true,
      );

  static Map<String, dynamic> toInsert({
    required String nombre,
    required TipoCliente tipo,
    String? contacto,
    String? zona,
  }) =>
      {
        ColCliente.nombre: nombre,
        ColCliente.tipo: tipo.wire,
        if (contacto != null) ColCliente.contacto: contacto,
        if (zona != null) ColCliente.zona: zona,
      };

  static Map<String, dynamic> toUpdate(Cliente c) => {
        ColCliente.nombre: c.nombre,
        ColCliente.tipo: c.tipo.wire,
        ColCliente.contacto: c.contacto,
        ColCliente.zona: c.zona,
        ColCliente.activo: c.activo,
      };
}
