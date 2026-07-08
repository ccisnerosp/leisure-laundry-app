import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/auth/cambiar_password_usecase.dart';
import '../../domain/usecases/auth/cerrar_sesion_usecase.dart';
import '../../domain/usecases/auth/iniciar_sesion_usecase.dart';
import '../../domain/usecases/auth/obtener_sesion_usecase.dart';
import '../../domain/usecases/ciclos/cerrar_ciclo_usecase.dart';
import '../../domain/usecases/ciclos/iniciar_ciclo_usecase.dart';
import '../../domain/usecases/ciclos/listar_ciclos_usecase.dart';
import '../../domain/usecases/ciclos/obtener_ciclo_en_curso_usecase.dart';
import '../../domain/usecases/clientes/actualizar_cliente_usecase.dart';
import '../../domain/usecases/clientes/cambiar_estado_cliente_usecase.dart';
import '../../domain/usecases/clientes/crear_cliente_usecase.dart';
import '../../domain/usecases/clientes/listar_clientes_usecase.dart';
import '../../domain/usecases/dashboard/obtener_ciclos_activos_usecase.dart';
import '../../domain/usecases/dashboard/obtener_estado_inventario_usecase.dart';
import '../../domain/usecases/dashboard/obtener_indicadores_turno_usecase.dart';
import '../../domain/usecases/dispositivos/registrar_token_usecase.dart';
import '../../domain/usecases/inventario/actualizar_umbral_usecase.dart';
import '../../domain/usecases/inventario/consultar_historial_usecase.dart';
import '../../domain/usecases/inventario/eliminar_dosis_usecase.dart';
import '../../domain/usecases/inventario/guardar_dosis_usecase.dart';
import '../../domain/usecases/inventario/listar_dosis_usecase.dart';
import '../../domain/usecases/inventario/listar_insumos_usecase.dart';
import '../../domain/usecases/inventario/registrar_ingreso_usecase.dart';
import '../../domain/usecases/notificaciones/consultar_notificaciones_usecase.dart';
import '../../domain/usecases/sync/sincronizar_usecase.dart';
import '../../domain/usecases/programas/actualizar_programa_usecase.dart';
import '../../domain/usecases/programas/cambiar_estado_programa_usecase.dart';
import '../../domain/usecases/programas/crear_programa_usecase.dart';
import '../../domain/usecases/programas/listar_programas_usecase.dart';
import '../../domain/usecases/usuarios/cambiar_estado_usuario_usecase.dart';
import '../../domain/usecases/usuarios/crear_usuario_usecase.dart';
import '../../domain/usecases/usuarios/listar_usuarios_usecase.dart';
import 'repository_providers.dart';

// Auth
final iniciarSesionUseCaseProvider = Provider(
    (ref) => IniciarSesionUseCase(ref.watch(authRepositoryProvider)));
final cerrarSesionUseCaseProvider = Provider(
    (ref) => CerrarSesionUseCase(ref.watch(authRepositoryProvider)));
final obtenerSesionUseCaseProvider = Provider(
    (ref) => ObtenerSesionUseCase(ref.watch(authRepositoryProvider)));
final cambiarPasswordUseCaseProvider = Provider(
    (ref) => CambiarPasswordUseCase(ref.watch(authRepositoryProvider)));

// Programas
final listarProgramasUseCaseProvider = Provider(
    (ref) => ListarProgramasUseCase(ref.watch(programaRepositoryProvider)));
final crearProgramaUseCaseProvider = Provider(
    (ref) => CrearProgramaUseCase(ref.watch(programaRepositoryProvider)));
final actualizarProgramaUseCaseProvider = Provider(
    (ref) => ActualizarProgramaUseCase(ref.watch(programaRepositoryProvider)));
final cambiarEstadoProgramaUseCaseProvider = Provider((ref) =>
    CambiarEstadoProgramaUseCase(ref.watch(programaRepositoryProvider)));

// Usuarios
final listarUsuariosUseCaseProvider = Provider(
    (ref) => ListarUsuariosUseCase(ref.watch(usuarioRepositoryProvider)));
final crearUsuarioUseCaseProvider = Provider(
    (ref) => CrearUsuarioUseCase(ref.watch(usuarioRepositoryProvider)));
final cambiarEstadoUsuarioUseCaseProvider = Provider((ref) =>
    CambiarEstadoUsuarioUseCase(ref.watch(usuarioRepositoryProvider)));

// Clientes
final listarClientesUseCaseProvider = Provider(
    (ref) => ListarClientesUseCase(ref.watch(clienteRepositoryProvider)));
final crearClienteUseCaseProvider = Provider(
    (ref) => CrearClienteUseCase(ref.watch(clienteRepositoryProvider)));
final actualizarClienteUseCaseProvider = Provider(
    (ref) => ActualizarClienteUseCase(ref.watch(clienteRepositoryProvider)));
final cambiarEstadoClienteUseCaseProvider = Provider(
    (ref) => CambiarEstadoClienteUseCase(ref.watch(clienteRepositoryProvider)));

// Inventario
final listarInsumosUseCaseProvider = Provider(
    (ref) => ListarInsumosUseCase(ref.watch(insumoRepositoryProvider)));
final registrarIngresoUseCaseProvider = Provider(
    (ref) => RegistrarIngresoUseCase(ref.watch(insumoRepositoryProvider)));
final listarDosisUseCaseProvider = Provider(
    (ref) => ListarDosisUseCase(ref.watch(dosisRepositoryProvider)));
final guardarDosisUseCaseProvider = Provider(
    (ref) => GuardarDosisUseCase(ref.watch(dosisRepositoryProvider)));
final eliminarDosisUseCaseProvider = Provider(
    (ref) => EliminarDosisUseCase(ref.watch(dosisRepositoryProvider)));
final consultarHistorialUseCaseProvider = Provider(
    (ref) => ConsultarHistorialUseCase(ref.watch(movimientoRepositoryProvider)));

final actualizarUmbralUseCaseProvider = Provider(
    (ref) => ActualizarUmbralUseCase(ref.watch(insumoRepositoryProvider)));

// Sincronización
final sincronizarUseCaseProvider = Provider(
    (ref) => SincronizarUseCase(ref.watch(syncRepositoryProvider)));

// Dashboard (Sprint 3)
final obtenerIndicadoresTurnoUseCaseProvider = Provider((ref) =>
    ObtenerIndicadoresTurnoUseCase(ref.watch(dashboardRepositoryProvider)));
final obtenerEstadoInventarioUseCaseProvider = Provider((ref) =>
    ObtenerEstadoInventarioUseCase(ref.watch(dashboardRepositoryProvider)));
final obtenerCiclosActivosUseCaseProvider = Provider((ref) =>
    ObtenerCiclosActivosUseCase(ref.watch(dashboardRepositoryProvider)));

// Notificaciones (Sprint 3)
final consultarNotificacionesUseCaseProvider = Provider((ref) =>
    ConsultarNotificacionesUseCase(ref.watch(notificacionRepositoryProvider)));

// Dispositivos / FCM (Sprint 3)
final registrarTokenUseCaseProvider = Provider(
    (ref) => RegistrarTokenUseCase(ref.watch(dispositivoRepositoryProvider)));

// Ciclos
final iniciarCicloUseCaseProvider = Provider((ref) => IniciarCicloUseCase(
      ref.watch(cicloRepositoryProvider),
      ref.watch(turnoRepositoryProvider),
    ));
final cerrarCicloUseCaseProvider = Provider(
    (ref) => CerrarCicloUseCase(ref.watch(cicloRepositoryProvider)));
final listarCiclosUseCaseProvider = Provider(
    (ref) => ListarCiclosUseCase(ref.watch(cicloRepositoryProvider)));
final obtenerCicloEnCursoUseCaseProvider = Provider((ref) =>
    ObtenerCicloEnCursoUseCase(ref.watch(cicloRepositoryProvider)));
