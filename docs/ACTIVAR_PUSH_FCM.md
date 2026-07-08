# Guía: Activar las notificaciones push de stock crítico (OM-03)

Esta guía detalla cómo poner en marcha, de extremo a extremo, la notificación push que avisa a la
gerencia cuando un insumo cae por debajo de su umbral mínimo.

## Cómo funciona (recordatorio del flujo)

```
Stock ≤ umbral  →  trigger fn_verificar_stock_critico  →  INSERT en notificaciones_stock
      →  Database Webhook (INSERT)  →  Edge Function notify-stock-critico
      →  FCM HTTP v1  →  📱 push al teléfono de cada usuario 'gerencial' con token activo
```

El destino del push son los **tokens FCM** guardados en la tabla `dispositivos_push` para los usuarios
con rol `gerencial` activos. El token se registra automáticamente cuando un gerencial inicia sesión.

## Estado: qué ya está listo y qué falta

| Componente | Estado |
|---|---|
| Código de la app (registro de token, manejo de push en primer/segundo plano, deep link) | ✅ Implementado |
| Gradle Android (plugin google-services declarado y aplicado condicionalmente) | ✅ Listo |
| Trigger de BD + tabla `notificaciones_stock` + Edge Function `notify-stock-critico` | ✅ Implementado |
| `google-services.json` en `android/app/` | ⛔ Falta (lo generas en Firebase) |
| Service account de Firebase como secret `FCM_SERVICE_ACCOUNT` | ⛔ Falta |
| Secrets de la Edge Function + despliegue | ⛔ Falta |
| Database Webhook (INSERT en `notificaciones_stock` → función) | ⛔ Falta |

**Datos del proyecto (referencia):**
- Package name Android (applicationId): `com.example.leisure`
- FCM Sender ID / número de proyecto Firebase: `727531555780`
- Nombre de la Edge Function: `notify-stock-critico`

---

## Parte A — Firebase: obtener `google-services.json`

1. Entra a <https://console.firebase.google.com> y abre tu proyecto (el que corresponde al número
   `727531555780`). Si no existe, crea uno nuevo.
2. En **Project Settings (⚙️) → General → Your apps**, pulsa **Add app → Android**.
3. En **Android package name** escribe exactamente:
   ```
   com.example.leisure
   ```
   (Apodo y SHA-1 son opcionales para el push; puedes dejarlos vacíos.)
4. Pulsa **Register app** y luego **Download google-services.json**.
5. Coloca ese archivo en:
   ```
   android/app/google-services.json
   ```
   > Ya está en `.gitignore`, así que no se subirá al repositorio (correcto: no debe versionarse).
6. Asegúrate de que **Cloud Messaging API (v1)** esté habilitada: Firebase Console → Project Settings →
   **Cloud Messaging**. Si aparece deshabilitada, actívala desde el enlace a Google Cloud Console.

---

## Parte B — Recompilar la app y verificar el registro del token

1. Recompila e instala (el plugin google-services se activa solo al detectar el archivo):
   ```
   flutter clean
   flutter pub get
   flutter build apk --release
   ```
2. Instala en un dispositivo/emulador **con Google Play Services** (los emuladores genéricos sin Play
   no reciben push; usa una imagen "Google Play" o un teléfono real).
3. Inicia sesión como **gerencial**. Al autenticar, la app pide permiso de notificaciones y registra
   el token FCM del dispositivo en la tabla `dispositivos_push`.
4. Verifica el registro (en el SQL Editor de Supabase):
   ```sql
   SELECT usuario_id, plataforma, activo, registrado_en
   FROM dispositivos_push
   ORDER BY registrado_en DESC;
   ```
   Debe aparecer una fila con `plataforma = 'android'`.

---

## Parte C — Firebase: generar el service account (`FCM_SERVICE_ACCOUNT`)

La Edge Function firma su petición a FCM con un service account de Firebase.

1. Firebase Console → **Project Settings (⚙️) → Service accounts**.
2. Pulsa **Generate new private key** → **Generate key**. Se descarga un archivo JSON (contiene
   `client_email`, `private_key`, `project_id`).
3. **Guárdalo en un lugar seguro. Es un secreto**: no lo subas al repositorio ni lo compartas.

---

## Parte D — Supabase: configurar secrets y desplegar la Edge Function

La función necesita tres secrets:

| Secret | Valor |
|---|---|
| `SUPABASE_URL` | La URL base de tu proyecto (`https://<TU-PROJECT-REF>.supabase.co`) |
| `SUPABASE_SERVICE_ROLE_KEY` | Tu `service_role` key **(usa la rotada, no una expuesta)** |
| `FCM_SERVICE_ACCOUNT` | El **contenido completo** del JSON de la Parte C, como una sola cadena |

Tienes dos caminos para desplegar. Elige uno.

### Opción D-1 — Con Supabase CLI (recomendado)

1. Instala la CLI (en Windows, con Scoop):
   ```
   scoop install supabase
   ```
   (Alternativas: `npm i -g supabase`, o el binario desde
   <https://github.com/supabase/cli/releases>.)
2. Autentícate y enlaza el proyecto:
   ```
   supabase login
   supabase link --project-ref <TU-PROJECT-REF>
   ```
3. Define los secrets:
   ```
   supabase secrets set SUPABASE_URL="https://<TU-PROJECT-REF>.supabase.co"
   supabase secrets set SUPABASE_SERVICE_ROLE_KEY="<TU-SERVICE-ROLE-KEY-ROTADA>"
   supabase secrets set FCM_SERVICE_ACCOUNT="$(cat ruta/al/service-account.json)"
   ```
4. Despliega la función:
   ```
   supabase functions deploy notify-stock-critico
   ```
   (Despliega también `crear-operario` si vas a crear usuarios desde la app:
   `supabase functions deploy crear-operario`.)

### Opción D-2 — Sin CLI, desde el Dashboard

1. Supabase Dashboard → **Edge Functions → Deploy a new function**.
2. Nombra la función `notify-stock-critico` y pega el contenido de
   `supabase/functions/notify-stock-critico/index.ts`.
3. En **Edge Functions → Settings → Secrets**, agrega los tres secrets de la tabla de arriba.

> URL resultante de la función:
> `https://<TU-PROJECT-REF>.supabase.co/functions/v1/notify-stock-critico`

---

## Parte E — Database Webhook (dispara la función en cada alerta)

1. Supabase Dashboard → **Database → Webhooks → Create a new hook**.
2. Configúralo así:
   - **Table:** `notificaciones_stock`
   - **Events:** `INSERT`
   - **Type:** *Supabase Edge Functions* (o *HTTP Request* apuntando a la URL de la función).
   - **URL:** `https://<TU-PROJECT-REF>.supabase.co/functions/v1/notify-stock-critico`
   - **HTTP Headers:** añade una cabecera de autorización para que la función acepte la invocación:
     ```
     Authorization: Bearer <TU-SERVICE-ROLE-KEY-ROTADA>
     ```
3. Guarda. A partir de ahora, cada fila nueva en `notificaciones_stock` invoca la función.

> La función soporta tanto el formato de webhook (`payload.record`) como una invocación directa, así
> que también puedes probarla manualmente.

---

## Parte F — Prueba de extremo a extremo

1. Asegúrate de tener la sesión gerencial iniciada en el dispositivo (token registrado, Parte B).
2. Provoca que un insumo cruce su umbral. La forma más simple, en el SQL Editor:
   ```sql
   -- Fuerza el stock por debajo del umbral para disparar el trigger + webhook
   UPDATE insumos
   SET stock_actual = umbral_minimo - 1
   WHERE nombre = 'Detergente líquido';
   ```
   (O, de forma realista, inicia ciclos desde la app hasta que el descuento automático baje el stock.)
3. Debe generarse una fila en `notificaciones_stock` y llegar el **push al teléfono del gerencial**
   con el título "Stock crítico" y el nombre del insumo.
4. Al tocar la notificación, la app abre el **dashboard gerencial** (deep link `leisure://dashboard`).

### Restaurar el stock para volver a probar
```sql
UPDATE insumos SET stock_actual = 10000 WHERE nombre = 'Detergente líquido';
```
Al subir el stock por encima del umbral, el trigger marca la notificación como `atendida`, lo que
permite que una nueva bajada vuelva a disparar el aviso (evita duplicados mientras el stock siga bajo).

---

## Diagnóstico de problemas

| Síntoma | Causa probable / solución |
|---|---|
| No se registra token en `dispositivos_push` | Falta `google-services.json`, o el dispositivo no tiene Google Play Services, o no se concedió permiso de notificaciones. |
| La función responde `{"sent":0,"reason":"sin tokens gerenciales"}` | No hay tokens de gerenciales activos: inicia sesión como gerencial primero. |
| La función devuelve error 500 | Revisa que `FCM_SERVICE_ACCOUNT` sea el JSON completo y válido, y que Cloud Messaging API (v1) esté habilitada. |
| Se crea la fila en `notificaciones_stock` pero no llega push | El webhook no está configurado o le falta la cabecera `Authorization`. Revisa los logs de la función en el Dashboard. |
| No se generan filas en `notificaciones_stock` | El stock no cruzó el umbral "hacia abajo", o ya había una notificación pendiente sin atender para ese insumo. |

---

## Nota de seguridad

- `google-services.json` y el JSON del service account **no** deben versionarse (el primero ya está en
  `.gitignore`). El service account es un secreto de administrador de Firebase.
- Usa siempre la `service_role` key **rotada**; nunca una que haya quedado expuesta.
