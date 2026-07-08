-- =============================================================================
-- Políticas RLS adicionales requeridas por la app (Sprint 1)
-- =============================================================================
-- El esquema base habilita RLS en `usuarios` pero NO define una política de
-- SELECT, por lo que la app no podría leer el propio perfil tras el login (y no
-- resolvería el rol). Estas políticas cierran ese hueco de forma segura.
--
-- Aplica este archivo en el SQL Editor de Supabase DESPUÉS de leisure_db_schema.sql
-- =============================================================================

-- Función auxiliar: indica si el usuario autenticado es gerencial.
-- Es SECURITY DEFINER para leer `usuarios` SIN volver a evaluar la RLS de esa
-- tabla; de lo contrario una política sobre `usuarios` que consulte `usuarios`
-- provoca «infinite recursion detected in policy» (error 42P17).
CREATE OR REPLACE FUNCTION public.es_gerencial()
    RETURNS boolean
    LANGUAGE sql
    STABLE
    SECURITY DEFINER
    SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.usuarios
        WHERE id = auth.uid() AND rol = 'gerencial'
    );
$$;

-- Cada usuario puede leer su propio perfil (necesario para resolver el rol).
CREATE POLICY pol_usuario_lee_su_perfil ON usuarios
    FOR SELECT TO authenticated
    USING (id = auth.uid());

-- El perfil gerencial puede leer todos los usuarios (HU-05.3).
CREATE POLICY pol_gerencial_lee_usuarios ON usuarios
    FOR SELECT TO authenticated
    USING (public.es_gerencial());

-- El usuario puede actualizar su propio flag password_temporal (HU-05.3).
CREATE POLICY pol_usuario_actualiza_su_perfil ON usuarios
    FOR UPDATE TO authenticated
    USING (id = auth.uid())
    WITH CHECK (id = auth.uid());

-- El perfil gerencial puede gestionar usuarios (activar/desactivar) (HU-05.3).
CREATE POLICY pol_gerencial_gestiona_usuarios ON usuarios
    FOR ALL TO authenticated
    USING (public.es_gerencial())
    WITH CHECK (public.es_gerencial());

-- Lectura de turnos para usuarios autenticados (se usa al asignar el turno
-- del ciclo). La tabla `turnos` no tiene RLS habilitado en el esquema base,
-- por lo que ya es legible; esta política se incluye por si se habilita RLS.
-- ALTER TABLE turnos ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY pol_lectura_turnos ON turnos
--     FOR SELECT TO authenticated USING (TRUE);

-- ===========================================================================
-- SPRINT 2 · Inventario y dosis
-- ===========================================================================

-- Dosis por programa (HU-03.2): el esquema base solo define SELECT. El perfil
-- gerencial debe poder crear/editar/eliminar dosis.
CREATE POLICY pol_gerencial_gestiona_dosis ON programa_insumo
    FOR ALL TO authenticated
    USING (public.es_gerencial())
    WITH CHECK (public.es_gerencial());

-- Movimientos de inventario (HU-03.3 / HU-03.4): la tabla tiene RLS habilitado
-- sin políticas, por lo que la app no puede leerlos ni insertarlos. Los
-- movimientos de descuento los crea el trigger (SECURITY DEFINER, sin RLS); el
-- resto (ingresos/ajustes y el historial) pasa por la API.
CREATE POLICY pol_lectura_movimientos ON movimientos_inventario
    FOR SELECT TO authenticated USING (TRUE);

CREATE POLICY pol_inserta_movimientos ON movimientos_inventario
    FOR INSERT TO authenticated WITH CHECK (TRUE);

-- Nota Realtime (HU-03.5): para recibir cambios de stock por el canal
-- `public:insumos`, agrega la tabla a la publicación de Realtime en el
-- dashboard (Database → Replication) o ejecuta:
--   ALTER PUBLICATION supabase_realtime ADD TABLE insumos;

-- ===========================================================================
-- SPRINT 3 · Dashboard y notificaciones push
-- ===========================================================================

-- Historial de notificaciones (HU-04.6): el perfil gerencial puede leerlas.
CREATE POLICY pol_gerencial_lee_notificaciones ON notificaciones_stock
    FOR SELECT TO authenticated
    USING (public.es_gerencial());

-- Tokens FCM (HU-04.5): cada usuario gestiona sus propios dispositivos.
CREATE POLICY pol_usuario_gestiona_dispositivos ON dispositivos_push
    FOR ALL TO authenticated
    USING (usuario_id = auth.uid())
    WITH CHECK (usuario_id = auth.uid());

-- Realtime del dashboard (HU-04.1): agrega las tablas a la publicación para
-- recibir cambios en `public:ciclos`, `public:insumos` y
-- `public:notificaciones_stock`:
--   ALTER PUBLICATION supabase_realtime ADD TABLE ciclos;
--   ALTER PUBLICATION supabase_realtime ADD TABLE insumos;
--   ALTER PUBLICATION supabase_realtime ADD TABLE notificaciones_stock;
