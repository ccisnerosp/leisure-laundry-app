// =============================================================================
// Tipos / metadatos del esquema Supabase (public) para Lavandería Leisure.
//
// NOTA: el comando `supabase gen types dart` NO existe en el CLI oficial
// (Supabase solo genera tipos TypeScript). Para el cliente Dart, la práctica
// equivalente y recomendada es centralizar los nombres de tablas y columnas
// como constantes para evitar "magic strings" dispersos por los repositorios.
// Este archivo cumple ese rol y refleja 1:1 `leisure_db_schema.sql`.
// =============================================================================

/// Nombres de tablas del esquema `public`.
abstract class Tablas {
  static const usuarios = 'usuarios';
  static const clientes = 'clientes';
  static const programas = 'programas';
  static const insumos = 'insumos';
  static const programaInsumo = 'programa_insumo';
  static const turnos = 'turnos';
  static const ciclos = 'ciclos';
  static const movimientosInventario = 'movimientos_inventario';
  static const notificacionesStock = 'notificaciones_stock';
  static const dispositivosPush = 'dispositivos_push';
}

/// Vistas del esquema (usadas a partir del Sprint 3).
abstract class Vistas {
  static const dashboardTurno = 'v_dashboard_turno';
  static const estadoInventario = 'v_estado_inventario';
}

/// Columnas de `usuarios`.
abstract class ColUsuario {
  static const id = 'id';
  static const email = 'email';
  static const nombre = 'nombre';
  static const rol = 'rol';
  static const passwordHash = 'password_hash';
  static const passwordTemporal = 'password_temporal';
  static const activo = 'activo';
  static const creadoEn = 'creado_en';
  static const actualizadoEn = 'actualizado_en';
}

/// Columnas de `programas`.
abstract class ColPrograma {
  static const id = 'id';
  static const nombre = 'nombre';
  static const tipo = 'tipo';
  static const duracionMinutos = 'duracion_minutos';
  static const activo = 'activo';
}

/// Columnas de `clientes`.
abstract class ColCliente {
  static const id = 'id';
  static const nombre = 'nombre';
  static const tipo = 'tipo';
  static const contacto = 'contacto';
  static const zona = 'zona';
  static const activo = 'activo';
}

/// Columnas de `turnos`.
abstract class ColTurno {
  static const id = 'id';
  static const nombre = 'nombre';
  static const horaInicio = 'hora_inicio';
  static const horaFin = 'hora_fin';
  static const activo = 'activo';
}

/// Columnas de `ciclos`.
abstract class ColCiclo {
  static const id = 'id';
  static const usuarioId = 'usuario_id';
  static const clienteId = 'cliente_id';
  static const programaId = 'programa_id';
  static const turnoId = 'turno_id';
  static const inicioEn = 'inicio_en';
  static const finEn = 'fin_en';
  static const estado = 'estado';
  static const sincronizado = 'sincronizado';
}

/// Columnas de `insumos`.
abstract class ColInsumo {
  static const id = 'id';
  static const nombre = 'nombre';
  static const unidad = 'unidad';
  static const stockActual = 'stock_actual';
  static const umbralMinimo = 'umbral_minimo';
  static const activo = 'activo';
}

/// Columnas de `programa_insumo`.
abstract class ColProgramaInsumo {
  static const id = 'id';
  static const programaId = 'programa_id';
  static const insumoId = 'insumo_id';
  static const dosis = 'dosis';
}

/// Columnas de `movimientos_inventario`.
abstract class ColMovimiento {
  static const id = 'id';
  static const insumoId = 'insumo_id';
  static const cicloId = 'ciclo_id';
  static const usuarioId = 'usuario_id';
  static const tipo = 'tipo';
  static const cantidad = 'cantidad';
  static const stockResultante = 'stock_resultante';
  static const registradoEn = 'registrado_en';
  static const sincronizado = 'sincronizado';
}

/// Columnas de `notificaciones_stock`.
abstract class ColNotificacion {
  static const id = 'id';
  static const insumoId = 'insumo_id';
  static const stockAlDisparar = 'stock_al_disparar';
  static const umbralAlDisparar = 'umbral_al_disparar';
  static const generadaEn = 'generada_en';
  static const atendida = 'atendida';
  static const atendidaEn = 'atendida_en';
}

/// Columnas de `dispositivos_push`.
abstract class ColDispositivo {
  static const id = 'id';
  static const usuarioId = 'usuario_id';
  static const tokenFcm = 'token_fcm';
  static const plataforma = 'plataforma';
  static const activo = 'activo';
  static const ultimaActividad = 'ultima_actividad';
}

/// Columnas de la vista `v_dashboard_turno`.
abstract class ColVDashboard {
  static const turnoId = 'turno_id';
  static const turnoNombre = 'turno_nombre';
  static const ciclosEnCurso = 'ciclos_en_curso';
  static const ciclosCompletados = 'ciclos_completados';
  static const minutosPromedio = 'minutos_promedio_ciclo';
}

/// Columnas de la vista `v_estado_inventario`.
abstract class ColVInventario {
  static const id = 'id';
  static const nombre = 'nombre';
  static const unidad = 'unidad';
  static const stockActual = 'stock_actual';
  static const umbralMinimo = 'umbral_minimo';
  static const estadoStock = 'estado_stock';
}
