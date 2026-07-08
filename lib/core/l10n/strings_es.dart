/// Centraliza TODO el texto visible de la aplicación (restricción del proyecto:
/// ningún widget hardcodea strings). Sprint 1.
abstract class S {
  // App
  static const String appNombre = 'Lavandería Leisure';

  // Login (HU-01.1)
  static const String loginTitulo = 'Iniciar sesión';
  static const String loginCorreo = 'Correo electrónico';
  static const String loginPassword = 'Contraseña';
  static const String loginIngresar = 'Ingresar';
  static const String loginMostrarPassword = 'Mostrar contraseña';
  static const String loginOcultarPassword = 'Ocultar contraseña';
  static const String loginErrorCredenciales =
      'Correo o contraseña incorrectos.';
  static const String loginErrorCorreoVacio = 'Ingresa tu correo.';
  static const String loginErrorCorreoInvalido = 'Correo no válido.';
  static const String loginErrorPasswordVacio = 'Ingresa tu contraseña.';

  // Cambio de contraseña temporal (HU-05.3)
  static const String cambioPasswordTitulo = 'Cambia tu contraseña';
  static const String cambioPasswordDescripcion =
      'Por seguridad, define una nueva contraseña antes de continuar.';
  static const String cambioPasswordNueva = 'Nueva contraseña';
  static const String cambioPasswordConfirmar = 'Confirmar contraseña';
  static const String cambioPasswordGuardar = 'Guardar y continuar';
  static const String cambioPasswordNoCoincide = 'Las contraseñas no coinciden.';
  static const String cambioPasswordMuyCorta =
      'La contraseña debe tener al menos 6 caracteres.';

  // Sesión / navegación (HU-01.3)
  static const String cerrarSesion = 'Cerrar sesión';
  static const String saludo = 'Hola';

  // Home gerencial
  static const String gerencialTitulo = 'Panel gerencial';
  static const String gerencialConfiguracion = 'Configuración maestra';
  static const String menuProgramas = 'Programas';
  static const String menuUsuarios = 'Usuarios';
  static const String menuClientes = 'Clientes';

  // Home operario
  static const String operarioTitulo = 'Gestión de ciclos';
  static const String operarioNuevoCiclo = 'Nuevo ciclo';
  static const String operarioSinCiclos = 'No hay ciclos registrados todavía.';

  // Programas (HU-05.2)
  static const String programasTitulo = 'Programas de lavado y secado';
  static const String programaNuevo = 'Nuevo programa';
  static const String programaEditar = 'Editar programa';
  static const String programaNombre = 'Nombre del programa';
  static const String programaTipo = 'Tipo';
  static const String programaTipoLavado = 'Lavado';
  static const String programaTipoSecado = 'Secado';
  static const String programaDuracion = 'Duración (minutos)';
  static const String programaActivo = 'Activo';
  static const String programaGuardar = 'Guardar programa';
  static const String programaSinRegistros = 'No hay programas configurados.';
  static const String programaErrorNombre = 'Ingresa un nombre.';
  static const String programaErrorDuracion =
      'La duración debe estar entre 1 y 240 minutos.';

  // Usuarios (HU-05.3)
  static const String usuariosTitulo = 'Usuarios operarios';
  static const String usuarioNuevo = 'Nuevo usuario';
  static const String usuarioNombre = 'Nombre completo';
  static const String usuarioCorreo = 'Correo electrónico';
  static const String usuarioRol = 'Rol';
  static const String usuarioRolOperario = 'Operario';
  static const String usuarioRolGerencial = 'Gerencial';
  static const String usuarioPasswordInicial = 'Contraseña inicial';
  static const String usuarioGuardar = 'Crear usuario';
  static const String usuarioSinRegistros = 'No hay usuarios registrados.';
  static const String usuarioErrorNombre = 'Ingresa el nombre.';
  static const String usuarioErrorCorreo = 'Ingresa un correo válido.';
  static const String usuarioErrorPassword =
      'La contraseña inicial debe tener al menos 6 caracteres.';

  // Estados / acciones genéricas
  static const String activar = 'Activar';
  static const String desactivar = 'Desactivar';
  static const String activo = 'Activo';
  static const String inactivo = 'Inactivo';
  static const String cancelar = 'Cancelar';
  static const String guardar = 'Guardar';
  static const String reintentar = 'Reintentar';
  static const String soloLectura = 'Solo lectura';

  // Ciclos (HU-02.x)
  static const String cicloIniciarTitulo = 'Iniciar ciclo';
  static const String cicloSeleccionarPrograma = 'Selecciona un programa';
  static const String cicloSeleccionarCliente = 'Selecciona un cliente';
  static const String cicloConfirmarInicio = 'Confirmar inicio';
  static const String cicloEnCurso = 'Ciclo en curso';
  static const String cicloTiempoRestante = 'Tiempo restante';
  static const String cicloPrograma = 'Programa';
  static const String cicloCliente = 'Cliente';
  static const String cicloFinalizado = '¡Ciclo finalizado!';
  static const String cicloRetirePrendas = 'He retirado las prendas';
  static const String cicloRetirarMensaje =
      'El ciclo terminó. Retira las prendas y confirma para cerrar el registro.';
  static const String cicloCompletado = 'Ciclo completado';
  static const String cicloSinProgramas =
      'No hay programas activos. Pide al gerente que configure uno.';
  static const String cicloSinClientes =
      'No hay clientes activos. Pide al gerente que registre uno.';
  static const String cicloEstadoEnCurso = 'En curso';
  static const String cicloEstadoCompletado = 'Completado';
  static const String cicloEstadoCancelado = 'Cancelado';

  // Notificación de fin de ciclo (HU-02.3)
  static const String notifCanalCiclosNombre = 'Alertas de ciclos';
  static const String notifCanalCiclosDesc =
      'Avisa cuando un ciclo de lavado o secado termina.';
  static const String notifFinTitulo = '¡Ciclo terminado!';
  static String notifFinCuerpo(String programa, String cliente) =>
      'El programa "$programa" para $cliente ha finalizado. Retira las prendas.';

  // Errores genéricos
  static const String errorGenerico = 'Ocurrió un error. Intenta nuevamente.';
  static const String errorSinConexion = 'Sin conexión a internet.';
  static const String errorServidor = 'No se pudo conectar con el servidor.';
  static const String errorCargandoDatos = 'No se pudieron cargar los datos.';

  // ===========================================================================
  // SPRINT 2 · Inventario y sincronización offline
  // ===========================================================================

  // Modo offline (HU-02.5)
  static const String modoOffline = 'Modo sin conexión';
  static const String sincronizando = 'Sincronizando…';
  static String pendientesSync(int n) =>
      '$n registro(s) pendiente(s) de sincronizar';
  static String syncCompletado(int n) => 'Se sincronizaron $n registro(s).';

  // Clientes (HU-05.1)
  static const String clientesTitulo = 'Clientes';
  static const String clienteNuevo = 'Nuevo cliente';
  static const String clienteEditar = 'Editar cliente';
  static const String clienteNombre = 'Nombre';
  static const String clienteTipo = 'Tipo';
  static const String clienteTipoHotel = 'Hotel';
  static const String clienteTipoAirbnb = 'Airbnb';
  static const String clienteTipoOtro = 'Otro';
  static const String clienteContacto = 'Contacto';
  static const String clienteZona = 'Zona';
  static const String clienteGuardar = 'Guardar cliente';
  static const String clienteSinRegistros = 'No hay clientes registrados.';
  static const String clienteErrorNombre = 'Ingresa el nombre del cliente.';

  // Inventario (HU-03.x)
  static const String inventarioTitulo = 'Inventario';
  static const String inventarioStock = 'Stock';
  static const String inventarioHistorial = 'Historial';
  static const String inventarioSinInsumos = 'No hay insumos registrados.';
  static const String inventarioRegistrarIngreso = 'Registrar ingreso';
  static const String inventarioStockActual = 'Stock actual';
  static const String inventarioUmbral = 'Umbral mínimo';

  // Ingreso de insumos (HU-03.3)
  static const String ingresoTitulo = 'Registrar ingreso';
  static const String ingresoInsumo = 'Insumo';
  static const String ingresoCantidad = 'Cantidad recibida';
  static const String ingresoGuardar = 'Registrar';
  static const String ingresoErrorInsumo = 'Selecciona un insumo.';
  static const String ingresoErrorCantidad = 'Ingresa una cantidad mayor a 0.';
  static const String ingresoOk = 'Ingreso registrado.';

  // Dosis por programa (HU-03.2)
  static const String dosisTitulo = 'Dosis por programa';
  static const String dosisAgregar = 'Agregar dosis';
  static const String dosisInsumo = 'Insumo';
  static const String dosisCantidad = 'Dosis';
  static const String dosisGuardar = 'Guardar dosis';
  static const String dosisSinRegistros =
      'Este programa no tiene dosis configuradas.';
  static const String dosisErrorValor = 'La dosis debe ser mayor a 0.';
  static const String dosisErrorInsumo = 'Selecciona un insumo.';

  // Historial de consumo (HU-03.4)
  static const String historialTitulo = 'Historial de consumo';
  static const String historialFiltroInsumo = 'Insumo';
  static const String historialFiltroTodos = 'Todos';
  static const String historialFiltroTurno = 'Turno';
  static const String historialFiltroDesde = 'Desde';
  static const String historialFiltroHasta = 'Hasta';
  static const String historialSinRegistros =
      'No hay movimientos para los filtros seleccionados.';
  static const String movDescuento = 'Descuento';
  static const String movIngreso = 'Ingreso';
  static const String movAjuste = 'Ajuste';

  // ===========================================================================
  // SPRINT 3 · Dashboard, notificaciones y pulido
  // ===========================================================================

  // Dashboard (HU-04.1 / HU-04.2)
  static const String dashboardTitulo = 'Dashboard';
  static const String dashboardIndicadores = 'Indicadores del turno';
  static const String dashboardCiclosActivos = 'Ciclos activos';
  static const String dashboardStock = 'Estado del inventario';
  static const String dashboardSinTurno = 'Sin turno activo en este momento.';
  static const String dashboardSinCiclosActivos = 'No hay ciclos en curso.';
  static const String indCiclosEnCurso = 'En curso';
  static const String indCiclosCompletados = 'Completados';
  static const String indPromedio = 'Prom. min/ciclo';
  static const String menuConfiguracion = 'Configuración';

  // Estados de stock (HU-04.1)
  static String estadoStockLabel(String estado) => switch (estado) {
        'critico' => 'Crítico',
        'bajo' => 'Bajo',
        _ => 'Normal',
      };

  // Umbrales (HU-04.3)
  static const String umbralEditar = 'Editar umbral mínimo';
  static const String umbralGuardar = 'Guardar umbral';
  static const String umbralLabel = 'Umbral mínimo';
  static const String umbralErrorValor = 'Ingresa un valor mayor o igual a 0.';
  static const String umbralOk = 'Umbral actualizado.';

  // Notificaciones (HU-04.4 / HU-04.5 / HU-04.6)
  static const String menuNotificaciones = 'Notificaciones';
  static const String notifHistorialTitulo = 'Historial de notificaciones';
  static const String notifHistorialVacio = 'No hay notificaciones registradas.';
  static const String notifStockTitulo = 'Stock crítico';
  static String notifStockCuerpo(String insumo, String stock) =>
      'El insumo "$insumo" está en stock crítico (quedan $stock).';
  static const String notifPendiente = 'Pendiente';
  static const String notifAtendida = 'Reabastecido';

  static String unidadLabel(String unidad) => switch (unidad) {
        'ml' => 'ml',
        'g' => 'g',
        _ => 'u',
      };

  static String tipoMovimientoLabel(String tipo) => switch (tipo) {
        'descuento' => movDescuento,
        'ingreso' => movIngreso,
        _ => movAjuste,
      };

  // Helpers de presentación
  static String tipoClienteLabel(String tipo) => switch (tipo) {
        'hotel' => 'Hotel',
        'airbnb' => 'Airbnb',
        _ => 'Otro',
      };
}
