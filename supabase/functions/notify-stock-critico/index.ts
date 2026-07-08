// =============================================================================
// Edge Function: notify-stock-critico  (HU-04.4 / HU-04.5)
// =============================================================================
// Se dispara por un Database Webhook en INSERT sobre `notificaciones_stock`.
// Envía una notificación push (FCM HTTP v1) a todos los usuarios con rol
// 'gerencial' que tengan tokens activos en `dispositivos_push`, con el nombre
// del insumo y el stock restante, e incluye un deep link al dashboard.
//
// Secrets requeridos (Project Settings → Edge Functions → Secrets):
//   SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
//   FCM_SERVICE_ACCOUNT  → JSON del service account de Firebase (como string)
//
// Deploy:  supabase functions deploy notify-stock-critico
// Webhook: Database → Webhooks → INSERT en notificaciones_stock → esta función.
// =============================================================================

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

interface ServiceAccount {
  client_email: string;
  private_key: string;
  project_id: string;
}

Deno.serve(async (req: Request) => {
  try {
    const payload = await req.json();
    const record = payload.record ?? payload; // soporta webhook o invocación directa
    const insumoId: string = record.insumo_id;
    const stock = record.stock_al_disparar;

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRole = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const admin = createClient(supabaseUrl, serviceRole);

    // a) Nombre del insumo.
    const { data: insumo } = await admin
      .from("insumos")
      .select("nombre")
      .eq("id", insumoId)
      .maybeSingle();
    const insumoNombre = insumo?.nombre ?? "insumo";

    // b) Tokens FCM activos de usuarios gerenciales.
    const { data: dispositivos } = await admin
      .from("dispositivos_push")
      .select("token_fcm, usuarios!inner(rol, activo)")
      .eq("activo", true)
      .eq("usuarios.rol", "gerencial")
      .eq("usuarios.activo", true);

    const tokens: string[] = (dispositivos ?? [])
      .map((d: { token_fcm: string }) => d.token_fcm)
      .filter(Boolean);
    if (tokens.length === 0) {
      return json({ sent: 0, reason: "sin tokens gerenciales" }, 200);
    }

    // c) Envía la push vía FCM HTTP v1.
    const sa = JSON.parse(Deno.env.get("FCM_SERVICE_ACCOUNT")!) as ServiceAccount;
    const accessToken = await getAccessToken(sa);

    let sent = 0;
    for (const token of tokens) {
      const message = {
        message: {
          token,
          notification: {
            title: "Stock crítico",
            body: `El insumo "${insumoNombre}" está en stock crítico (quedan ${stock}).`,
          },
          data: { deeplink: "leisure://dashboard", insumo: insumoNombre, stock: String(stock) },
          android: { priority: "high" },
        },
      };
      const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${sa.project_id}/messages:send`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${accessToken}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(message),
        },
      );
      if (res.ok) sent++;
    }

    return json({ sent }, 200);
  } catch (e) {
    return json({ error: String(e) }, 500);
  }
});

// --- OAuth2: intercambia el service account por un access token (RS256 JWT) ---
async function getAccessToken(sa: ServiceAccount): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = { alg: "RS256", typ: "JWT" };
  const claims = {
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };

  const enc = (obj: unknown) =>
    base64url(new TextEncoder().encode(JSON.stringify(obj)));
  const unsigned = `${enc(header)}.${enc(claims)}`;

  const key = await crypto.subtle.importKey(
    "pkcs8",
    pemToArrayBuffer(sa.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    new TextEncoder().encode(unsigned),
  );
  const jwt = `${unsigned}.${base64url(new Uint8Array(signature))}`;

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });
  const data = await res.json();
  return data.access_token as string;
}

function base64url(bytes: Uint8Array): string {
  let bin = "";
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const body = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, "")
    .replace(/-----END PRIVATE KEY-----/, "")
    .replace(/\s+/g, "");
  const bin = atob(body);
  const buf = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) buf[i] = bin.charCodeAt(i);
  return buf.buffer;
}

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
