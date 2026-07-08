# Documento de Contexto — App Móvil "Lavandería Leisure"

> **Propósito de este documento.** Reúne, de forma autocontenida, toda la información necesaria para
> redactar un informe de proyecto (Trabajo Final, metodología SCRUM). No requiere acceso a ningún
> otro archivo: el modelo de datos, el product backlog, el stack y las reglas de negocio están
> incorporados aquí íntegramente. La información no sigue el orden de ningún índice concreto; está
> organizada por temas para poder rellenar cualquier apartado sin dependencias externas.

---

## 1. Ficha resumen del proyecto

| Campo | Detalle |
|---|---|
| **Nombre** | Lavandería Leisure — Aplicación Móvil de Digitalización de Procesos Operativos |
| **Código de estudiante** | U202214987 |
| **Tipo** | Trabajo Final (aplicación móvil multiplataforma) |
| **Metodología** | SCRUM, 3 sprints |
| **Cliente / caso de estudio** | Lavandería Leisure — PYME peruana de lavandería industrial B2B (Lima) |
| **Sector del cliente** | Servicios de lavandería industrial para hoteles y alojamientos tipo Airbnb |
| **Plataforma** | Aplicación móvil Flutter (Android e iOS), backend en la nube (Supabase) |
| **Estado** | Las 24 HU del backlog tienen cobertura de código; los 3 sprints están implementados; verificado en ejecución (compila, pruebas en verde, login y dashboard con datos reales funcionando en emulador Android) |

**Descripción en una línea:** aplicación que digitaliza tres procesos operativos críticos de una
lavandería industrial —cronometrado de ciclos, control de inventario y supervisión gerencial— que
antes se realizaban de forma manual y propensa a error.

---

## 2. Problema, contexto y oportunidades de mejora

### 2.1. Situación (As-Is)
Lavandería Leisure es una pequeña empresa que presta servicio de lavado industrial a hoteles y
alojamientos Airbnb en Lima. Sus procesos operativos se gestionaban manualmente, lo que generaba
tres problemas concretos:

1. **Cronometrado manual de ciclos.** El operario debía recordar o vigilar cuándo terminaba cada
   ciclo de lavado/secado. Esto producía tiempos muertos (máquinas terminadas y desatendidas) o ropa
   olvidada dentro de la máquina, reduciendo la productividad.
2. **Inventario a ciegas.** El consumo de insumos (detergente, suavizante) no se registraba por
   ciclo. No existía visibilidad del stock real ni del momento de reposición, con riesgo de quiebre
   de stock que detiene la operación.
3. **Falta de visibilidad gerencial.** La gerencia no disponía de información en tiempo real de la
   operación ni de alertas ante situaciones críticas (p. ej., stock bajo), dificultando la toma de
   decisiones.

### 2.2. Oportunidades de mejora (OM) — eje del proyecto
El proyecto se estructura alrededor de tres oportunidades de mejora, una por sprint:

| OM | Nombre | Problema que resuelve | Sprint |
|---|---|---|---|
| **OM-01** | Temporizador de ciclos con alerta automática al operario | Fin de ciclo impredecible / desatendido | 1 |
| **OM-02** | Control de inventario virtual con descuento automático por ciclo | Inventario sin trazabilidad, quiebres de stock | 2 |
| **OM-03** | Dashboard gerencial con notificación push de stock crítico | Falta de visibilidad y alertas para la gerencia | 3 |

### 2.3. Propuesta de valor (To-Be)
Automatizar lo que antes era manual: cronometrar (con alerta local que funciona incluso con la app
cerrada), descontar insumos automáticamente al iniciar cada ciclo (regla de negocio en la base de
datos), y vigilar el stock con notificación push a la gerencia. El hilo conductor es trasladar la
regla de negocio a mecanismos automáticos y confiables (triggers de base de datos, notificaciones
del sistema operativo), reduciendo la dependencia del cliente móvil y del factor humano.

---

## 3. Objetivos

**Objetivo general.** Desarrollar una aplicación móvil multiplataforma que digitalice y automatice
los procesos operativos críticos de Lavandería Leisure, mejorando la productividad del operario y la
capacidad de supervisión de la gerencia.

**Objetivos específicos.**
- OE1. Implementar un temporizador de ciclos con alerta automática de fin, operativo aun sin
  conexión y con la app en segundo plano (OM-01).
- OE2. Implementar un control de inventario virtual con descuento automático de insumos por ciclo y
  trazabilidad de movimientos, con soporte offline (OM-02).
- OE3. Proveer a la gerencia un dashboard en tiempo real y notificaciones push ante stock crítico
  (OM-03).
- OE4. Garantizar seguridad (autenticación por roles, sin credenciales expuestas) y calidad
  (arquitectura limpia, pruebas automatizadas, accesibilidad).

---

## 4. Alcance

**Incluido.** Autenticación con roles y sesión persistida; ciclo completo de OM-01 (selección →
inicio + temporizador → alerta → cierre); gestión de programas, clientes y usuarios; inventario
(stock, ingresos, historial, dosis por programa) con descuento automático; sincronización offline
bidireccional; dashboard gerencial en tiempo real; notificaciones push de stock crítico; modo oscuro
y accesibilidad (targets táctiles ≥ 48 dp).

**Excluido / fuera de alcance.** Registro público autoservicio (SignUp): por diseño de seguridad, las
altas de usuario son por aprovisionamiento controlado desde el perfil gerencial (modelo B2B interno,
principio de menor privilegio). No se contemplan pagos, facturación, ni módulos de logística de
recojo/entrega.

### 4.1. Perfiles de usuario (roles)
| Rol | Descripción | Uso principal |
|---|---|---|
| **operario** | Especialista en Procesos de Lavado; usa la app en planta | Inicia/cierra ciclos, ve temporizador, registra ingresos de inventario |
| **gerencial** | Supervisor / CTO / COO | Dashboard, configuración (programas, clientes, dosis, umbrales), gestión de usuarios, recibe push |

---

## 5. Metodología y organización por sprints

Metodología **SCRUM** con 3 sprints, cada uno centrado en una oportunidad de mejora. El product
backlog consta de **24 historias de usuario (HU)** agrupadas en 6 épicas.

| Sprint | Foco (OM) | Entregables clave |
|---|---|---|
| **Sprint 1** | OM-01 | Autenticación y roles, persistencia segura de sesión, gestión de programas y usuarios, ciclo completo OM-01 (selección → inicio + temporizador → alerta de fin → cierre) |
| **Sprint 2** | OM-02 | Gestión de clientes (CRUD), inventario (stock, ingresos, historial filtrable), dosis por programa, descuento de insumos (trigger server-side online / lógica local offline), sincronización offline bidireccional con banner "Modo sin conexión" |
| **Sprint 3** | OM-03 | Dashboard gerencial en tiempo real (Supabase Realtime), configuración de umbrales, notificaciones push de stock crítico (FCM + Edge Function), historial de notificaciones, modo oscuro y accesibilidad (targets ≥ 48 dp) |

---

## 6. Product Backlog completo (24 HU en 6 épicas)

> Las descripciones reflejan el comportamiento efectivamente implementado. Los códigos HU son los
> usados en el código fuente y la base de datos.

### Épica 01 — Autenticación y acceso (Sprint 1)
- **HU-01.1** — Iniciar sesión con correo y contraseña. Ante error no se revela si falló el correo o
  la contraseña (mensaje genérico "Correo o contraseña incorrectos"), por seguridad.
- **HU-01.2** — Redirección según rol tras autenticar (operario → pantalla de planta; gerencial →
  dashboard).
- **HU-01.3** — Persistencia segura de sesión: la sesión se guarda en almacenamiento cifrado del
  dispositivo y se restaura al reabrir la app (sin pedir login de nuevo).

### Épica 02 — Ciclos y temporizador (OM-01, Sprint 1)
- **HU-02.1** — Seleccionar programa y cliente para un nuevo ciclo.
- **HU-02.2** — Iniciar ciclo: valida que el programa y el cliente estén activos, asigna el turno que
  contiene la hora de inicio y propaga la duración del programa al ciclo.
- **HU-02.3** — Temporizador con cuenta regresiva (HH:MM:SS) y alerta automática al finalizar
  (notificación local con sonido), incluso con la app en segundo plano o cerrada.
- **HU-02.4** — Cerrar ciclo: lo marca como completado y registra la hora de fin.
- **HU-02.5** — Crear ciclo estando sin conexión y sincronizarlo automáticamente al reconectar.

### Épica 03 — Inventario (OM-02, Sprint 2)
- **HU-03.1** — Listar insumos con su stock actual y estado (normal / bajo / crítico).
- **HU-03.2** — Configurar la dosis de cada insumo por programa (receta de consumo).
- **HU-03.3** — Registrar ingreso/ajuste de stock de un insumo.
- **HU-03.4** — Consultar el historial de movimientos de inventario (descuentos, ingresos, ajustes),
  filtrable.
- **HU-03.5** — Sincronización de inventario y recepción de cambios en tiempo real.

### Épica 04 — Dashboard y notificaciones (OM-03, Sprint 3)
- **HU-04.1** — Ver el estado del inventario en el dashboard (clasificación normal/bajo/crítico).
- **HU-04.2** — Ver indicadores del turno en curso (ciclos en curso, completados, minutos promedio
  por ciclo).
- **HU-04.3** — Ver los ciclos activos en tiempo real.
- **HU-04.4** — Generar automáticamente una notificación cuando un insumo cruza su umbral mínimo.
- **HU-04.5** — Registrar el token FCM del dispositivo gerencial y recibir push; mostrar aviso en
  primer plano con acción para abrir el dashboard.
- **HU-04.6** — Consultar el historial de notificaciones de stock.

### Épica 05 — Administración / configuración (Sprints 1–2)
- **HU-05.1** — Gestionar programas de lavado/secado (crear, editar, activar/desactivar).
- **HU-05.2** — Gestionar clientes (CRUD).
- **HU-05.3** — Crear usuarios (operarios) con contraseña inicial temporal; el usuario debe cambiarla
  en el primer login. La creación se hace del lado servidor (ver §11, Edge Function).

### Épica 06 — Calidad y experiencia transversal
- **HU-06.1** — Operar en Android 8.0 (API 26) o superior (minSdk = 26).
- **HU-06.2** — Soporte de modo oscuro siguiendo la preferencia del sistema operativo; targets
  táctiles de tamaño accesible (≥ 48×48 dp).

### Requisitos funcionales destacados (referenciados en la base de datos)
- **RF-13** — Descuento automático de insumos al iniciar un ciclo.
- **RF-20** — Generación de notificación cuando un insumo cruza el umbral mínimo.

### Requisitos no funcionales
- **Seguridad:** autenticación por roles; sin credenciales hardcodeadas; Row Level Security en la
  base de datos; no se almacenan contraseñas en texto plano (las gestiona Supabase Auth).
- **Disponibilidad offline:** funciones críticas del operario operan sin conexión (temporizador,
  registro de ciclos y movimientos) con sincronización posterior.
- **Usabilidad/accesibilidad:** interfaz en español, modo oscuro, targets táctiles ≥ 48 dp.
- **Mantenibilidad:** arquitectura limpia por capas; código estático sin warnings; pruebas
  automatizadas.
- **Compatibilidad:** Android 8.0+ / iOS 14+.

---

## 7. Stack tecnológico

| Capa | Tecnología | Versión / nota |
|---|---|---|
| Lenguaje | Dart | 3.8.x (SDK ^3.8.0) |
| Framework UI | Flutter | multiplataforma (Android/iOS) |
| Gestión de estado | Riverpod (`flutter_riverpod`, `riverpod_annotation`) | ^2.5 |
| Navegación | `go_router` | ^14.2 |
| Backend / Auth / Realtime | Supabase (`supabase_flutter`) | ^2.5.6 (PostgreSQL + Auth + Realtime + Edge Functions) |
| Base de datos | PostgreSQL 15+ (gestionado por Supabase) | — |
| Persistencia local offline | Isar (`isar`, `isar_flutter_libs`) | ^3.1 |
| Almacenamiento seguro de sesión | `flutter_secure_storage` | ^9.2 |
| Notificaciones locales + sonido | `flutter_local_notifications`, `audioplayers`, `timezone` | ^17.2 / ^6.0 |
| Notificaciones push | Firebase Cloud Messaging (`firebase_core`, `firebase_messaging`) | ^3.6 / ^15.1 |
| Conectividad / sincronización | `connectivity_plus`, `uuid` | ^6.0 / ^4.4 |
| Variables de entorno (secretos) | `envied` (+ `envied_generator`) | ^0.5.4 (ofusca valores en compilación) |
| Generación de código | `build_runner`, `isar_generator`, `riverpod_generator`, `envied_generator` | — |
| Calidad estática | `flutter_lints` | ^6.0 |
| Edge Functions | Deno / TypeScript (en Supabase) | — |

---

## 8. Arquitectura de software

**Patrón:** Clean Architecture en 3 capas + presentación, con regla de dependencias estricta
(las capas externas dependen de las internas, nunca al revés).

```
lib/
├── core/          # Transversal: manejo de errores (Either<Failure,T>), i18n (strings_es),
│                  #   theme (claro/oscuro), router, servicios (alarma, notificaciones,
│                  #   conectividad, push), utilidades (formato de tiempo)
├── data/          # Implementaciones de repositorios; fuentes local (Isar) y remota (Supabase);
│                  #   DTOs; mappers; servicios de caché/realtime; almacenamiento seguro
├── domain/        # Entidades (Ciclo, Insumo, Usuario, ...); interfaces de repositorios;
│                  #   casos de uso (un archivo por caso de uso)
└── presentation/  # Pantallas, widgets y providers Riverpod (única capa que orquesta la UI)
```

**Reglas arquitectónicas respetadas (verificadas):**
- `presentation/` nunca importa Supabase ni Isar directamente; solo depende de las **interfaces** de
  `domain/`, inyectadas mediante providers de Riverpod.
- Cada caso de uso vive en su propio archivo dentro de `domain/usecases/`.
- Manejo de errores funcional con `Either<Failure, T>` (sin excepciones propagadas a la UI).
- Todo texto visible está centralizado en un único archivo de strings en español.
- Sin credenciales hardcodeadas: se cargan desde variables de entorno y `envied` las inyecta
  ofuscadas en tiempo de compilación.

**Flujo de arranque de la app (orden):** inicialización de Firebase (tolerante a fallo si no hay
configuración) → inicialización de Supabase con sesión persistida en almacenamiento seguro → apertura
de la base local Isar → inicialización de notificaciones locales → restauración de sesión + permisos
+ arranque del monitor de conectividad/sincronización.

---

## 9. Modelo de datos (PostgreSQL / Supabase)

### 9.1. Tipos enumerados
- `rol_usuario`: `operario`, `gerencial`
- `tipo_cliente`: `hotel`, `airbnb`, `otro`
- `tipo_programa`: `lavado`, `secado`
- `unidad_insumo`: `ml`, `g`, `unidad`
- `estado_ciclo`: `en_curso`, `completado`, `cancelado`
- `tipo_movimiento`: `descuento`, `ingreso`, `ajuste`

### 9.2. Tablas (10)
| Tabla | Propósito | Columnas relevantes |
|---|---|---|
| **usuarios** | Operarios y gerenciales autenticados | `id` (UUID = auth.uid), `email` (único), `nombre`, `rol`, `password_temporal`, `activo` |
| **clientes** | Catálogo B2B (hoteles/Airbnb) | `nombre`, `tipo`, `contacto`, `zona`, `activo` |
| **programas** | Programas de lavado/secado | `nombre`, `tipo`, `duracion_minutos` (1–240), `activo` |
| **insumos** | Inventario virtual de consumibles | `nombre` (único), `unidad`, `stock_actual`, `umbral_minimo`, `activo` |
| **programa_insumo** | Puente N:M: receta de dosis por programa | `programa_id`, `insumo_id`, `dosis` (>0), único por par |
| **turnos** | Turnos operativos para agrupar indicadores | `nombre` (único), `hora_inicio`, `hora_fin` |
| **ciclos** | Registro central de ciclos productivos | `usuario_id`, `cliente_id`, `programa_id`, `turno_id`, `inicio_en`, `fin_en`, `estado`, `sincronizado` |
| **movimientos_inventario** | Trazabilidad de stock | `insumo_id`, `ciclo_id`, `usuario_id`, `tipo`, `cantidad`, `stock_resultante`, `sincronizado` |
| **notificaciones_stock** | Alertas de stock crítico | `insumo_id`, `stock_al_disparar`, `umbral_al_disparar`, `atendida` |
| **dispositivos_push** | Tokens FCM por usuario gerencial | `usuario_id`, `token_fcm` (único), `plataforma` (android/ios), `activo` |

Datos semilla base del esquema: dos turnos ("Turno mañana" 06:00–14:00, "Turno tarde" 14:00–22:00).

### 9.3. Lógica de negocio en la base de datos (triggers y funciones)
- **`fn_actualizar_timestamp`** (+ triggers `BEFORE UPDATE`): mantiene `actualizado_en` en las tablas.
- **`fn_descontar_insumos_por_ciclo`** (trigger `AFTER INSERT ON ciclos`, **RF-13 / OM-02**): al crear
  un ciclo `en_curso`, recorre la receta (`programa_insumo`) del programa, descuenta la dosis de cada
  insumo (`insumos.stock_actual`) y registra un movimiento tipo `descuento` con el `stock_resultante`.
  Así el inventario es siempre coherente sin intervención manual.
- **`fn_verificar_stock_critico`** (trigger `AFTER UPDATE OF stock_actual ON insumos`, **RF-20 / OM-03**):
  cuando un insumo cruza el umbral mínimo hacia abajo genera una notificación (evitando duplicados
  mientras no se atienda); cuando el stock se recupera por encima del umbral marca las notificaciones
  como atendidas.

### 9.4. Vistas
- **`v_dashboard_turno`** (HU-04.2): por turno del día actual, cuenta ciclos en curso y completados y
  calcula los minutos promedio por ciclo completado.
- **`v_estado_inventario`** (HU-04.1): por insumo activo, clasifica el stock en `critico`
  (`stock ≤ umbral`), `bajo` (`stock ≤ umbral × 1.5`) o `normal`.

### 9.5. Seguridad a nivel de fila (Row Level Security)
RLS habilitado en las 10 tablas. Políticas base: lectura de catálogos para usuarios autenticados; el
operario solo puede crear ciclos a su propio nombre (`usuario_id = auth.uid()`); solo el rol
gerencial puede modificar catálogos (clientes, programas, insumos) y gestionar usuarios; cada usuario
puede leer/actualizar su propio perfil; el gerencial puede leer todos los usuarios y las
notificaciones; cada usuario gestiona sus propios dispositivos push.

> **Nota técnica de diseño (importante para el informe):** las políticas del rol gerencial que
> consultan la tabla `usuarios` se resuelven mediante una función `SECURITY DEFINER`
> (`public.es_gerencial()`) que lee el rol sin re-evaluar la RLS de `usuarios`. Esto evita el error de
> "recursión infinita en política" (PostgreSQL 42P17) que se produce cuando una política sobre
> `usuarios` consulta la propia tabla `usuarios`. Es un patrón estándar de Supabase para verificación
> de rol en RLS.

---

## 10. Reglas y decisiones de negocio destacadas

- **Precisión del temporizador (OM-01):** el tiempo restante se calcula a partir de marcas absolutas
  (`inicio_en` + `duracion_minutos`), por lo que es exacto aunque la app pase a segundo plano o se
  reabra. La alerta de fin se programa como notificación local exacta que se dispara incluso con la
  app cerrada.
- **Descuento offline vs. online (OM-02):** online, el descuento lo hace el trigger del servidor
  (autoritativo). Offline, la lógica de descuento se ejecuta localmente en Dart. Al sincronizar un
  ciclo creado offline, se inserta en estado `en_curso` para que el trigger genere el descuento y los
  movimientos autoritativos; los movimientos `descuento` locales se reconcilian (se marcan
  sincronizados sin reenviarse) para **evitar doble descuento**.
- **Sin registro público (SignUp):** decisión de seguridad. Las altas son por aprovisionamiento del
  gerencial; el nuevo usuario recibe contraseña temporal y la cambia en el primer login.

---

## 11. Backend en Supabase (Edge Functions)

Dos funciones serverless (Deno/TypeScript):
- **`crear-operario`** (HU-05.3): crea de forma atómica la credencial en Supabase Auth y el perfil en
  `usuarios`. Verifica que el invocador esté autenticado y tenga rol gerencial; valida el cuerpo; usa
  la clave de servicio (`service_role`, solo del lado servidor, nunca en el cliente); si falla el
  insert del perfil, revierte la credencial creada (rollback).
- **`notify-stock-critico`** (OM-03): envía la notificación push (FCM) al gerencial ante stock
  crítico.

---

## 12. Seguridad (resumen para el informe)
- Autenticación email/contraseña gestionada por Supabase Auth (las contraseñas no se almacenan en la
  tabla de la app; el campo de hash es un marcador gestionado por Auth).
- Autorización por rol reforzada en dos niveles: la app enruta según rol y la base de datos aplica RLS.
- Secretos fuera del código: variables de entorno inyectadas y ofuscadas por `envied`; el archivo de
  entorno está excluido del control de versiones.
- Operaciones privilegiadas (crear usuarios) delegadas a Edge Function con `service_role` del lado
  servidor.
- Mensajes de error de login que no revelan qué campo falló.

---

## 13. Pruebas y aseguramiento de calidad

- **Análisis estático:** `flutter analyze` → 0 issues (0 errores, 0 warnings).
- **Pruebas automatizadas:** `flutter test` → 24/24 en verde. Cubren:
  - Formato de tiempo del temporizador (HH:MM:SS).
  - Lógica del dominio del ciclo (OM-01): cálculo de fin programado, decremento del tiempo restante,
    no-negatividad tras el fin, estado en curso.
  - Caso de uso Iniciar/Cerrar ciclo (validaciones de programa/cliente activo, asignación de turno,
    propagación de duración).
  - Clasificación de stock (crítico/bajo/normal) y validaciones de casos de uso del Sprint 2
    (crear cliente, registrar ingreso, guardar dosis, sincronizar).
  - Accesibilidad: targets táctiles de botones e íconos ≥ 48×48 dp.

### 13.1. Verificación funcional en ejecución (realizada)
Se compiló el APK de release, se instaló y ejecutó en un emulador Android y se validó el flujo real
extremo a extremo: autenticación contra Supabase, resolución de rol vía RLS y carga del **dashboard
gerencial con datos en vivo** (indicadores de turno, "no hay ciclos en curso", e inventario real:
Detergente líquido 10 000 ml y Suavizante 8 000 ml, ambos clasificados como "Normal"). Esto confirma
que las tres capas (app → Auth/RLS → vistas de dashboard) operan integradas.

---

## 14. Estado del proyecto y checklist de cierre

- [x] Las 24 HU del product backlog tienen cobertura de código.
- [x] Sin credenciales hardcodeadas (variables de entorno + `envied`, archivo de entorno ignorado).
- [x] Todos los strings visibles centralizados en español.
- [x] Ningún widget importa Supabase ni Isar directamente (solo vía providers).
- [x] Modelos Isar con su código generado.
- [x] `flutter analyze` → 0 issues.
- [x] `flutter test` → 100% (incluye accesibilidad 48×48 dp).
- [x] Base de datos aprovisionada y verificada (esquema, políticas, datos semilla, usuarios de
      prueba); login gerencial y dashboard funcionando en emulador.
- [ ] Edge Functions desplegadas y push FCM activo en producción (requiere configuración de Firebase
      `google-services.json` + despliegue de la función).
- [ ] Build de release instalada en dispositivo físico Android 8.0+ / iOS 14+.

---

## 15. Limitaciones conocidas

- **Push (FCM):** la app compila y corre sin el archivo de configuración de Firebase; en ese caso la
  inicialización de Firebase falla de forma controlada y el push queda desactivado (degradación
  elegante). Se activa al añadir el archivo de configuración y desplegar la Edge Function.
- **Sonido de alarma:** usa un archivo de audio local; si falta, la alerta sonora la cubre la
  notificación de alta importancia del sistema operativo.
- **Bootstrap del primer usuario gerencial:** la función de creación de usuarios requiere un gerencial
  existente para invocarla, por lo que el primer gerencial se crea directamente en el backend
  (dashboard/seed) — es un paso de puesta en marcha, no una limitación de uso.

---

## 16. Puesta en marcha (resumen, sin secretos)

1. Instalar dependencias y generar código: `flutter pub get` y luego el generador de código
   (`build_runner`) para producir los archivos de Isar y de variables de entorno.
2. Variables de entorno necesarias (en un archivo de entorno, nunca versionado):
   `SUPABASE_URL` (URL base del proyecto, **sin** sufijos de ruta), `SUPABASE_ANON_KEY` (clave
   pública anónima) y opcionalmente `FCM_SENDER_ID` (para push). Tras cambiarlas hay que regenerar el
   código para que se reinyecten.
3. Base de datos: aplicar el esquema (tablas, triggers, vistas), las políticas RLS de la app y los
   datos semilla; crear los usuarios de prueba en Auth (un gerencial y un operario).
4. (Opcional) Desplegar las Edge Functions y configurar Firebase para habilitar el push.

**Usuarios y roles de prueba (para demostración):**
- `gerente@leisure.pe` — rol gerencial.
- `operario@leisure.pe` — rol operario (con contraseña temporal: se fuerza el cambio en el primer
  login).

---

## 17. Glosario rápido

| Término | Significado |
|---|---|
| **Ciclo** | Ejecución de un programa de lavado/secado sobre la ropa de un cliente |
| **Programa** | Configuración de lavado o secado con una duración fija (minutos) |
| **Dosis** | Cantidad de un insumo que consume un programa (receta), usada para el descuento |
| **Insumo** | Consumible del inventario (detergente, suavizante, etc.) |
| **Umbral mínimo** | Nivel de stock que dispara la notificación de stock crítico |
| **Turno** | Franja horaria operativa que agrupa ciclos para los indicadores |
| **Movimiento** | Cambio de stock registrado: descuento (automático), ingreso o ajuste |
| **RLS** | Row Level Security: control de acceso por fila en PostgreSQL |
| **Edge Function** | Función serverless en Supabase (Deno/TypeScript) para lógica del lado servidor |
```
