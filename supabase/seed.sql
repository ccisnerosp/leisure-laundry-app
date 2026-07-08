-- =============================================================================
-- DATOS SEMILLA · Sprint 1 · Lavandería Leisure
-- =============================================================================
-- Requisito previo: crea PRIMERO las credenciales en Supabase Auth
-- (Dashboard → Authentication → Users → Add user), con estos correos:
--
--     gerente@leisure.pe     (contraseña a tu elección)
--     operario@leisure.pe    (contraseña a tu elección)
--
-- Luego ejecuta este archivo en el SQL Editor. Vincula el perfil de `usuarios`
-- con el id real del usuario de `auth.users` por correo, de modo que
-- `usuarios.id = auth.uid()` (lo que exigen las políticas RLS).
-- =============================================================================

-- 1 usuario gerencial de prueba
INSERT INTO usuarios (id, email, nombre, rol, password_hash, password_temporal, activo)
SELECT u.id, 'gerente@leisure.pe', 'Gerente Demo', 'gerencial',
       'gestionado_por_supabase_auth', FALSE, TRUE
FROM auth.users u
WHERE u.email = 'gerente@leisure.pe'
ON CONFLICT (id) DO NOTHING;

-- 1 usuario operario de prueba (debe cambiar contraseña en el primer login)
INSERT INTO usuarios (id, email, nombre, rol, password_hash, password_temporal, activo)
SELECT u.id, 'operario@leisure.pe', 'Operario Demo', 'operario',
       'gestionado_por_supabase_auth', TRUE, TRUE
FROM auth.users u
WHERE u.email = 'operario@leisure.pe'
ON CONFLICT (id) DO NOTHING;

-- 2 programas (1 lavado 40 min, 1 secado 60 min)
INSERT INTO programas (nombre, tipo, duracion_minutos, activo) VALUES
    ('Lavado estándar', 'lavado', 40, TRUE),
    ('Secado completo',  'secado', 60, TRUE)
ON CONFLICT DO NOTHING;

-- 2 clientes (1 hotel, 1 airbnb)
INSERT INTO clientes (nombre, tipo, contacto, zona, activo) VALUES
    ('Hotel Costa del Sol', 'hotel',  'reservas@costasol.pe', 'Miraflores', TRUE),
    ('Airbnb Barranco Loft', 'airbnb', 'host@barrancoloft.pe', 'Barranco',  TRUE)
ON CONFLICT DO NOTHING;

-- Los 2 turnos (mañana 06:00-14:00, tarde 14:00-22:00) ya se insertan en
-- leisure_db_schema.sql. Si no existen, descomenta:
-- INSERT INTO turnos (nombre, hora_inicio, hora_fin) VALUES
--     ('Turno mañana', '06:00:00', '14:00:00'),
--     ('Turno tarde',  '14:00:00', '22:00:00')
-- ON CONFLICT (nombre) DO NOTHING;

-- Insumos de ejemplo
INSERT INTO insumos (nombre, unidad, stock_actual, umbral_minimo, activo) VALUES
    ('Detergente líquido', 'ml', 10000, 1000, TRUE),
    ('Suavizante',         'ml', 8000,  800,  TRUE)
ON CONFLICT (nombre) DO NOTHING;

-- Dosis por programa (Sprint 2, HU-03.2): el programa de lavado consume
-- detergente y suavizante; el trigger los descuenta al iniciar el ciclo.
INSERT INTO programa_insumo (programa_id, insumo_id, dosis)
SELECT p.id, i.id, 120
FROM programas p, insumos i
WHERE p.nombre = 'Lavado estándar' AND i.nombre = 'Detergente líquido'
ON CONFLICT (programa_id, insumo_id) DO NOTHING;

INSERT INTO programa_insumo (programa_id, insumo_id, dosis)
SELECT p.id, i.id, 60
FROM programas p, insumos i
WHERE p.nombre = 'Lavado estándar' AND i.nombre = 'Suavizante'
ON CONFLICT (programa_id, insumo_id) DO NOTHING;
