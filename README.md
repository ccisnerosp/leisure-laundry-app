# Lavandería Leisure · App Móvil

Aplicación móvil multiplataforma (Flutter) para digitalizar los procesos
operativos críticos de Lavandería Leisure, una PYME peruana de lavandería
industrial B2B (hoteles y alojamientos Airbnb en Lima).

Cubre tres oportunidades de mejora:

- **OM-01** · Temporizador de ciclos con alerta automática al operario.
- **OM-02** · Control de inventario virtual con descuento por ciclo *(Sprint 2)*.
- **OM-03** · Dashboard gerencial con notificación push de stock crítico *(Sprint 3)*.

## Perfiles de usuario

- **operario** → Especialista en Procesos de Lavado (usa la app en planta).
- **gerencial** → Supervisor / CTO / COO (supervisión y configuración).

---

## Stack técnico

| Capa | Tecnología |
|---|---|
| Framework | Flutter (Dart) |
| Estado | Riverpod |
| Backend / Auth / Realtime | Supabase (PostgreSQL + Auth) |
| Persistencia local (offline) | Isar |
| Notificaciones locales | flutter_local_notifications + audioplayers |
| Notificaciones push | Firebase Cloud Messaging *(Sprint 3)* |
| Navegación | go_router |
| Variables de entorno | envied |

## Arquitectura (Clean Architecture, 3 capas)

```
lib/
├── core/            # transversal: errores, l10n, theme, router, servicios, utils
├── data/            # repos (impl), fuentes local (Isar) y remota (Supabase), DTOs
├── domain/          # entidades, interfaces de repositorios, casos de uso
└── presentation/    # pantallas, widgets y providers Riverpod
```

Reglas respetadas:

- `presentation/` nunca importa Supabase ni Isar directamente; depende solo de
  las **interfaces** de `domain/`.
- Cada caso de uso vive en su propio archivo en `lib/domain/usecases/`.
- Todo texto visible está en `lib/core/l10n/strings_es.dart`.
- Manejo de errores con `Either<Failure, T>` (`lib/core/error/`).
- Sin credenciales hardcodeadas: se cargan desde `.env` vía `envied`.

---

## Configuración del entorno

### 1. Requisitos

- Flutter 3.32+ (Dart 3.8+)
- Cuenta y proyecto de Supabase
- (Opcional para creación de usuarios) Supabase CLI para desplegar Edge Functions

### 2. Variables de entorno

Copia la plantilla y completa los valores:

```bash
cp .env.example .env
```

`.env` (ya está en `.gitignore`, **nunca se commitea**):

```
SUPABASE_URL=https://TU_PROYECTO.supabase.co
SUPABASE_ANON_KEY=TU_ANON_KEY
FCM_SENDER_ID=        # se usa desde el Sprint 3
```

> `envied` inyecta estos valores (ofuscados) en `lib/env/env.g.dart` durante el
> codegen. Si cambias el `.env`, vuelve a ejecutar `build_runner`.

### 3. Instalar dependencias y generar código

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Esto genera los `.g.dart` de **Isar** (`ciclo_local.g.dart`) y **envied**
(`env.g.dart`).

### 4. Preparar la base de datos en Supabase

En el **SQL Editor** del dashboard de Supabase, ejecuta en orden:

1. `supabase/leisure_db_schema.sql` — crea 10 tablas, 2 triggers de negocio
   (`fn_descontar_insumos_por_ciclo`, `fn_verificar_stock_critico`) y 2 vistas
   (`v_dashboard_turno`, `v_estado_inventario`).
2. `supabase/policies_app.sql` — políticas RLS que la app necesita para leer el
   perfil del usuario tras el login.
3. Crea los usuarios de prueba en **Authentication → Users**:
   - `gerente@leisure.pe`
   - `operario@leisure.pe`
4. `supabase/seed.sql` — vincula los perfiles, e inserta programas, clientes e
   insumos de prueba.

### 5. (Opcional) Desplegar la Edge Function de creación de usuarios

La creación de usuarios operarios desde la app (HU-05.3) requiere crear la
credencial en Auth con la `service_role` key, lo cual **solo** puede hacerse del
lado servidor. Despliega:

```bash
supabase functions deploy crear-operario
```

### 6. (Sprint 3) Notificaciones push con Firebase Cloud Messaging

El push es **opcional**: la app compila y funciona sin Firebase. Para activarlo:

1. Crea un proyecto en Firebase y registra las apps Android/iOS.
2. Coloca los archivos de configuración (están en `.gitignore`):
   - `android/app/google-services.json` — el plugin de Gradle se aplica
     automáticamente solo cuando este archivo existe.
   - `ios/Runner/GoogleService-Info.plist`.
3. Despliega la Edge Function que envía las push al insertarse una notificación:
   ```bash
   supabase functions deploy notify-stock-critico
   ```
   Configura sus secrets (`FCM_SERVICE_ACCOUNT` con el JSON del service account).
4. En el dashboard de Supabase crea un **Database Webhook**: INSERT en
   `notificaciones_stock` → invoca `notify-stock-critico`.
5. Habilita Realtime para el dashboard:
   ```sql
   ALTER PUBLICATION supabase_realtime ADD TABLE ciclos;
   ALTER PUBLICATION supabase_realtime ADD TABLE insumos;
   ALTER PUBLICATION supabase_realtime ADD TABLE notificaciones_stock;
   ```

### 7. Ejecutar la app

```bash
flutter run
```

### 8. Builds de release

```bash
flutter build apk --release        # Android (Android 8.0+ / minSdk 26)
flutter build ipa --release        # iOS (requiere macOS + certificados)
```

---

## Pruebas

```bash
flutter test        # pruebas unitarias (casos de uso de ciclos, temporizador)
flutter analyze     # análisis estático (0 issues)
```

---

## Estado por sprint

- **Sprint 1 (actual)** — Autenticación y roles, persistencia de sesión segura,
  gestión de programas y usuarios, y el ciclo completo de OM-01 (selección →
  inicio + temporizador → alerta de fin → cierre).
- **Sprint 2 (actual)** — Gestión de clientes (CRUD), inventario (stock,
  ingresos, historial filtrable), configuración de dosis por programa,
  descuento de insumos (server-side online vía trigger / local en Dart offline),
  y sincronización offline bidireccional con banner de "Modo sin conexión".
- **Sprint 3 (actual)** — Dashboard gerencial en tiempo real (Supabase Realtime),
  configuración de umbrales, notificaciones push de stock crítico (FCM + Edge
  Function), historial de notificaciones, modo oscuro y touch targets ≥48 dp.

## Checklist de cierre (Sprint 3)

- [x] Las 24 HUs del product backlog tienen cobertura de código.
- [x] No hay credenciales hardcodeadas (`.env` + envied; `.env` en `.gitignore`).
- [x] Todos los strings visibles están en `strings_es.dart`.
- [x] Ningún widget importa Supabase ni Isar directamente (sólo providers).
- [x] Los modelos Isar tienen sus `.g.dart` generados.
- [x] `flutter analyze` → 0 errores y 0 warnings.
- [x] `flutter test` → 100% (incluye touch targets 48×48 dp).
- [ ] Edge Functions desplegadas y webhook configurado *(requiere tu Supabase + Firebase)*.
- [ ] Build de release instalada en dispositivo físico Android 8.0+ / iOS 14+ *(requiere tu hardware)*.

## Notas / limitaciones conocidas

- El sonido de alarma en primer plano usa `assets/sounds/alarma.mp3`. Coloca tu
  propio archivo ahí (ver `assets/sounds/README.txt`). Si falta, la alerta
  sonora la cubre la notificación de alta importancia del sistema operativo.
- El temporizador calcula el tiempo restante a partir de marcas de tiempo
  absolutas (`inicio_en` + duración), por lo que es preciso aunque la app pase a
  segundo plano o se reabra. La alerta de fin se programa como notificación
  local exacta, que se dispara incluso con la app cerrada.
- **Push (FCM)**: la app compila y corre sin `google-services.json`. Sin ese
  archivo, `Firebase.initializeApp()` falla de forma controlada y el push queda
  desactivado; al añadir el archivo + desplegar la Edge Function, se activa.
- **Conflicto trigger/offline (Sprint 2)**: al sincronizar un ciclo creado
  offline se inserta en estado `en_curso` para que el trigger del servidor genere
  el descuento y los movimientos autoritativos; los movimientos `descuento`
  locales se reconcilian (se marcan sincronizados sin reenviarse) para evitar
  doble descuento.
