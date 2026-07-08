// =============================================================================
// Edge Function: crear-operario  (HU-05.3)
// =============================================================================
// Crea de forma atómica la credencial en Supabase Auth y el perfil en la tabla
// `usuarios`. Usa la SERVICE_ROLE key (solo del lado servidor; NUNCA en el
// cliente). Solo un usuario con rol 'gerencial' puede invocarla.
//
// Deploy:  supabase functions deploy crear-operario
// =============================================================================

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRole = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;

    // 1) Verifica que quien invoca sea un usuario gerencial autenticado.
    const authHeader = req.headers.get("Authorization") ?? "";
    const asCaller = createClient(supabaseUrl, anonKey, {
      global: { headers: { Authorization: authHeader } },
    });
    const { data: { user: caller } } = await asCaller.auth.getUser();
    if (!caller) {
      return json({ error: "No autenticado" }, 401);
    }

    const admin = createClient(supabaseUrl, serviceRole);
    const { data: perfilCaller } = await admin
      .from("usuarios")
      .select("rol")
      .eq("id", caller.id)
      .maybeSingle();
    if (!perfilCaller || perfilCaller.rol !== "gerencial") {
      return json({ error: "Requiere rol gerencial" }, 403);
    }

    // 2) Valida el cuerpo.
    const { nombre, email, rol, password } = await req.json();
    if (!nombre || !email || !rol || !password) {
      return json({ error: "Faltan campos obligatorios" }, 400);
    }
    if (rol !== "operario" && rol !== "gerencial") {
      return json({ error: "Rol inválido" }, 400);
    }

    // 3) Crea la credencial en Auth (email confirmado).
    const { data: created, error: authErr } = await admin.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
    });
    if (authErr || !created.user) {
      return json({ error: authErr?.message ?? "No se pudo crear la credencial" }, 400);
    }

    // 4) Crea el perfil en `usuarios` con password_temporal = true.
    const { data: usuario, error: insErr } = await admin
      .from("usuarios")
      .insert({
        id: created.user.id,
        nombre,
        email,
        rol,
        password_hash: "gestionado_por_supabase_auth",
        password_temporal: true,
        activo: true,
      })
      .select()
      .single();

    if (insErr) {
      // Rollback de la credencial si el perfil falla.
      await admin.auth.admin.deleteUser(created.user.id);
      return json({ error: insErr.message }, 400);
    }

    return json({ usuario }, 200);
  } catch (e) {
    return json({ error: String(e) }, 500);
  }
});

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}
