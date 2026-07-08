-- =============================================================================
-- LAVANDERÍA LEISURE · App Móvil de Digitalización de Procesos Operativos
-- Esquema de Base de Datos · PostgreSQL 15+ / Supabase
-- =============================================================================
-- Cubre las tres oportunidades de mejora:
--   OM-01 · Temporizador de ciclos con alerta automática
--   OM-02 · Control de inventario virtual con descuento automático
--   OM-03 · Dashboard gerencial con notificación ante stock crítico
-- =============================================================================

-- Extensión para generar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================================================
-- TIPOS ENUMERADOS
-- =============================================================================

CREATE TYPE rol_usuario AS ENUM ('operario', 'gerencial');
CREATE TYPE tipo_cliente AS ENUM ('hotel', 'airbnb', 'otro');
CREATE TYPE tipo_programa AS ENUM ('lavado', 'secado');
CREATE TYPE unidad_insumo AS ENUM ('ml', 'g', 'unidad');
CREATE TYPE estado_ciclo AS ENUM ('en_curso', 'completado', 'cancelado');
CREATE TYPE tipo_movimiento AS ENUM ('descuento', 'ingreso', 'ajuste');

-- =============================================================================
-- TABLA: usuarios
-- Operarios, supervisores y CTO/COO que acceden a la app
-- =============================================================================

CREATE TABLE usuarios (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    email               VARCHAR(150)    NOT NULL UNIQUE,
    nombre              VARCHAR(120)    NOT NULL,
    rol                 rol_usuario     NOT NULL,
    password_hash       TEXT            NOT NULL,
    password_temporal   BOOLEAN         NOT NULL DEFAULT TRUE,
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    actualizado_en      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_usuarios_email ON usuarios(email) WHERE activo = TRUE;
CREATE INDEX idx_usuarios_rol ON usuarios(rol) WHERE activo = TRUE;

COMMENT ON TABLE usuarios IS 'Usuarios autenticados de la app móvil';
COMMENT ON COLUMN usuarios.password_temporal IS 'TRUE si requiere cambio de contraseña en el siguiente login (HU-05.3)';

-- =============================================================================
-- TABLA: clientes
-- Hoteles y alojamientos Airbnb a los que se les presta servicio
-- =============================================================================

CREATE TABLE clientes (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre              VARCHAR(150)    NOT NULL,
    tipo                tipo_cliente    NOT NULL,
    contacto            VARCHAR(120),
    zona                VARCHAR(100),
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    actualizado_en      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_clientes_activo ON clientes(activo) WHERE activo = TRUE;
CREATE INDEX idx_clientes_nombre ON clientes(nombre);

COMMENT ON TABLE clientes IS 'Catálogo de clientes B2B que se vinculan a cada ciclo';

-- =============================================================================
-- TABLA: programas
-- Programas de lavado y secado configurables
-- =============================================================================

CREATE TABLE programas (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre              VARCHAR(120)    NOT NULL,
    tipo                tipo_programa   NOT NULL,
    duracion_minutos    INTEGER         NOT NULL CHECK (duracion_minutos > 0 AND duracion_minutos <= 240),
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    actualizado_en      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_programas_tipo ON programas(tipo) WHERE activo = TRUE;

COMMENT ON TABLE programas IS 'Catálogo de programas de lavado y secado con su duración';
COMMENT ON COLUMN programas.duracion_minutos IS 'Tiempo total del ciclo, usado por el temporizador (OM-01)';

-- =============================================================================
-- TABLA: insumos
-- Catálogo de detergentes, suavizantes y otros consumibles
-- =============================================================================

CREATE TABLE insumos (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre              VARCHAR(120)    NOT NULL UNIQUE,
    unidad              unidad_insumo   NOT NULL,
    stock_actual        DECIMAL(10,2)   NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    umbral_minimo       DECIMAL(10,2)   NOT NULL DEFAULT 0 CHECK (umbral_minimo >= 0),
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    actualizado_en      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_insumos_stock_critico ON insumos(stock_actual, umbral_minimo)
    WHERE activo = TRUE AND stock_actual <= umbral_minimo;

COMMENT ON TABLE insumos IS 'Inventario virtual de insumos (OM-02)';
COMMENT ON COLUMN insumos.umbral_minimo IS 'Punto de disparo para notificación de stock crítico (OM-03)';

-- =============================================================================
-- TABLA: programa_insumo (puente N:M)
-- Define qué dosis de cada insumo consume cada programa
-- =============================================================================

CREATE TABLE programa_insumo (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    programa_id         UUID            NOT NULL REFERENCES programas(id) ON DELETE CASCADE,
    insumo_id           UUID            NOT NULL REFERENCES insumos(id) ON DELETE RESTRICT,
    dosis               DECIMAL(10,2)   NOT NULL CHECK (dosis > 0),
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_programa_insumo UNIQUE (programa_id, insumo_id)
);

CREATE INDEX idx_programa_insumo_programa ON programa_insumo(programa_id);
CREATE INDEX idx_programa_insumo_insumo ON programa_insumo(insumo_id);

COMMENT ON TABLE programa_insumo IS 'Receta de dosis por programa para el descuento automático (OM-02)';

-- =============================================================================
-- TABLA: turnos
-- Configuración de turnos operativos para agrupar indicadores
-- =============================================================================

CREATE TABLE turnos (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre              VARCHAR(60)     NOT NULL,
    hora_inicio         TIME            NOT NULL,
    hora_fin            TIME            NOT NULL,
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT uq_turno_nombre UNIQUE (nombre)
);

COMMENT ON TABLE turnos IS 'Turnos operativos para agrupar ciclos en el dashboard (HU-04.2)';

-- =============================================================================
-- TABLA: ciclos
-- Registro de cada ciclo de lavado o secado ejecutado
-- =============================================================================

CREATE TABLE ciclos (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    usuario_id          UUID            NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    cliente_id          UUID            NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT,
    programa_id         UUID            NOT NULL REFERENCES programas(id) ON DELETE RESTRICT,
    turno_id            UUID            REFERENCES turnos(id) ON DELETE SET NULL,
    inicio_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    fin_en              TIMESTAMPTZ,
    estado              estado_ciclo    NOT NULL DEFAULT 'en_curso',
    sincronizado        BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en           TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    actualizado_en      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_fin_posterior_inicio CHECK (fin_en IS NULL OR fin_en >= inicio_en)
);

CREATE INDEX idx_ciclos_estado ON ciclos(estado);
CREATE INDEX idx_ciclos_usuario ON ciclos(usuario_id);
CREATE INDEX idx_ciclos_cliente ON ciclos(cliente_id);
CREATE INDEX idx_ciclos_turno ON ciclos(turno_id);
CREATE INDEX idx_ciclos_inicio_en ON ciclos(inicio_en DESC);
CREATE INDEX idx_ciclos_no_sincronizados ON ciclos(sincronizado) WHERE sincronizado = FALSE;

COMMENT ON TABLE ciclos IS 'Registro central de ciclos productivos (OM-01)';
COMMENT ON COLUMN ciclos.sincronizado IS 'FALSE si el ciclo fue creado offline y aún no se replicó (HU-02.5)';

-- =============================================================================
-- TABLA: movimientos_inventario
-- Historial de descuentos automáticos, ingresos y ajustes de stock
-- =============================================================================

CREATE TABLE movimientos_inventario (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    insumo_id           UUID            NOT NULL REFERENCES insumos(id) ON DELETE RESTRICT,
    ciclo_id            UUID            REFERENCES ciclos(id) ON DELETE SET NULL,
    usuario_id          UUID            NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    tipo                tipo_movimiento NOT NULL,
    cantidad            DECIMAL(10,2)   NOT NULL CHECK (cantidad > 0),
    stock_resultante    DECIMAL(10,2)   NOT NULL CHECK (stock_resultante >= 0),
    registrado_en       TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    sincronizado        BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_ciclo_para_descuento
        CHECK (tipo <> 'descuento' OR ciclo_id IS NOT NULL)
);

CREATE INDEX idx_movimientos_insumo ON movimientos_inventario(insumo_id);
CREATE INDEX idx_movimientos_ciclo ON movimientos_inventario(ciclo_id);
CREATE INDEX idx_movimientos_usuario ON movimientos_inventario(usuario_id);
CREATE INDEX idx_movimientos_tipo ON movimientos_inventario(tipo);
CREATE INDEX idx_movimientos_fecha ON movimientos_inventario(registrado_en DESC);
CREATE INDEX idx_movimientos_no_sincronizados ON movimientos_inventario(sincronizado)
    WHERE sincronizado = FALSE;

COMMENT ON TABLE movimientos_inventario IS 'Trazabilidad de movimientos de inventario (OM-02, HU-03.4)';
COMMENT ON COLUMN movimientos_inventario.stock_resultante IS 'Stock del insumo tras aplicar el movimiento (para auditoría)';

-- =============================================================================
-- TABLA: notificaciones_stock
-- Registro de notificaciones generadas por stock crítico
-- =============================================================================

CREATE TABLE notificaciones_stock (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    insumo_id           UUID            NOT NULL REFERENCES insumos(id) ON DELETE CASCADE,
    stock_al_disparar   DECIMAL(10,2)   NOT NULL,
    umbral_al_disparar  DECIMAL(10,2)   NOT NULL,
    generada_en         TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    atendida            BOOLEAN         NOT NULL DEFAULT FALSE,
    atendida_en         TIMESTAMPTZ
);

CREATE INDEX idx_notificaciones_insumo ON notificaciones_stock(insumo_id);
CREATE INDEX idx_notificaciones_atendida ON notificaciones_stock(atendida);
CREATE INDEX idx_notificaciones_fecha ON notificaciones_stock(generada_en DESC);

COMMENT ON TABLE notificaciones_stock IS 'Notificaciones push de stock crítico (OM-03, HU-04.4, HU-04.6)';
COMMENT ON COLUMN notificaciones_stock.atendida IS 'Evita duplicados mientras el stock siga bajo el umbral';

-- =============================================================================
-- TABLA: dispositivos_push
-- Tokens FCM por usuario gerencial para envío de notificaciones
-- =============================================================================

CREATE TABLE dispositivos_push (
    id                  UUID            PRIMARY KEY DEFAULT uuid_generate_v4(),
    usuario_id          UUID            NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    token_fcm           TEXT            NOT NULL UNIQUE,
    plataforma          VARCHAR(10)     NOT NULL CHECK (plataforma IN ('android', 'ios')),
    activo              BOOLEAN         NOT NULL DEFAULT TRUE,
    registrado_en       TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    ultima_actividad    TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_dispositivos_usuario ON dispositivos_push(usuario_id) WHERE activo = TRUE;

COMMENT ON TABLE dispositivos_push IS 'Tokens FCM para entrega de notificaciones (HU-04.5)';

-- =============================================================================
-- TRIGGER: actualización automática de timestamps
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_usuarios_actualizado BEFORE UPDATE ON usuarios
    FOR EACH ROW EXECUTE FUNCTION fn_actualizar_timestamp();

CREATE TRIGGER trg_clientes_actualizado BEFORE UPDATE ON clientes
    FOR EACH ROW EXECUTE FUNCTION fn_actualizar_timestamp();

CREATE TRIGGER trg_programas_actualizado BEFORE UPDATE ON programas
    FOR EACH ROW EXECUTE FUNCTION fn_actualizar_timestamp();

CREATE TRIGGER trg_insumos_actualizado BEFORE UPDATE ON insumos
    FOR EACH ROW EXECUTE FUNCTION fn_actualizar_timestamp();

CREATE TRIGGER trg_ciclos_actualizado BEFORE UPDATE ON ciclos
    FOR EACH ROW EXECUTE FUNCTION fn_actualizar_timestamp();

-- =============================================================================
-- TRIGGER: descuento automático de insumos al iniciar ciclo (OM-02)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_descontar_insumos_por_ciclo()
RETURNS TRIGGER AS $$
DECLARE
    receta RECORD;
    nuevo_stock DECIMAL(10,2);
BEGIN
    -- Solo procesa al crear un ciclo nuevo en estado 'en_curso'
    IF NEW.estado = 'en_curso' THEN
        FOR receta IN
            SELECT pi.insumo_id, pi.dosis
            FROM programa_insumo pi
            WHERE pi.programa_id = NEW.programa_id
        LOOP
            -- Calcula el nuevo stock y lo actualiza
            UPDATE insumos
            SET stock_actual = stock_actual - receta.dosis
            WHERE id = receta.insumo_id
            RETURNING stock_actual INTO nuevo_stock;

            -- Registra el movimiento
            INSERT INTO movimientos_inventario
                (insumo_id, ciclo_id, usuario_id, tipo, cantidad, stock_resultante)
            VALUES
                (receta.insumo_id, NEW.id, NEW.usuario_id, 'descuento',
                 receta.dosis, nuevo_stock);
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ciclo_inicia_descuento
    AFTER INSERT ON ciclos
    FOR EACH ROW EXECUTE FUNCTION fn_descontar_insumos_por_ciclo();

COMMENT ON FUNCTION fn_descontar_insumos_por_ciclo IS
    'Descuento automático de insumos al iniciar un ciclo (RF-13)';

-- =============================================================================
-- TRIGGER: generación de notificación ante stock crítico (OM-03)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_verificar_stock_critico()
RETURNS TRIGGER AS $$
DECLARE
    notificacion_pendiente BOOLEAN;
BEGIN
    -- Solo verifica si el stock cruzó el umbral hacia abajo
    IF NEW.stock_actual <= NEW.umbral_minimo
       AND (OLD.stock_actual > OLD.umbral_minimo OR OLD.stock_actual IS NULL) THEN

        -- Verifica que no exista una notificación pendiente para este insumo
        SELECT EXISTS (
            SELECT 1 FROM notificaciones_stock
            WHERE insumo_id = NEW.id AND atendida = FALSE
        ) INTO notificacion_pendiente;

        IF NOT notificacion_pendiente THEN
            INSERT INTO notificaciones_stock
                (insumo_id, stock_al_disparar, umbral_al_disparar)
            VALUES
                (NEW.id, NEW.stock_actual, NEW.umbral_minimo);
        END IF;
    END IF;

    -- Si el stock se recuperó por encima del umbral, marca notificaciones como atendidas
    IF NEW.stock_actual > NEW.umbral_minimo
       AND OLD.stock_actual <= OLD.umbral_minimo THEN
        UPDATE notificaciones_stock
        SET atendida = TRUE, atendida_en = NOW()
        WHERE insumo_id = NEW.id AND atendida = FALSE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_insumo_stock_critico
    AFTER UPDATE OF stock_actual ON insumos
    FOR EACH ROW EXECUTE FUNCTION fn_verificar_stock_critico();

COMMENT ON FUNCTION fn_verificar_stock_critico IS
    'Genera notificación cuando un insumo cruza el umbral mínimo (RF-20)';

-- =============================================================================
-- VISTA: dashboard del turno activo (HU-04.1, HU-04.2)
-- =============================================================================

CREATE OR REPLACE VIEW v_dashboard_turno AS
SELECT
    t.id AS turno_id,
    t.nombre AS turno_nombre,
    COUNT(c.id) FILTER (WHERE c.estado = 'en_curso') AS ciclos_en_curso,
    COUNT(c.id) FILTER (WHERE c.estado = 'completado') AS ciclos_completados,
    AVG(EXTRACT(EPOCH FROM (c.fin_en - c.inicio_en))/60)
        FILTER (WHERE c.estado = 'completado') AS minutos_promedio_ciclo
FROM turnos t
LEFT JOIN ciclos c ON c.turno_id = t.id
    AND c.inicio_en >= DATE_TRUNC('day', NOW())
WHERE t.activo = TRUE
GROUP BY t.id, t.nombre;

COMMENT ON VIEW v_dashboard_turno IS 'Indicadores agregados del turno en curso (HU-04.2)';

-- =============================================================================
-- VISTA: estado actual de inventario (HU-04.1)
-- =============================================================================

CREATE OR REPLACE VIEW v_estado_inventario AS
SELECT
    i.id,
    i.nombre,
    i.unidad,
    i.stock_actual,
    i.umbral_minimo,
    CASE
        WHEN i.stock_actual <= i.umbral_minimo THEN 'critico'
        WHEN i.stock_actual <= (i.umbral_minimo * 1.5) THEN 'bajo'
        ELSE 'normal'
    END AS estado_stock
FROM insumos i
WHERE i.activo = TRUE
ORDER BY estado_stock, i.nombre;

COMMENT ON VIEW v_estado_inventario IS 'Resumen de stock con clasificación visual (HU-04.1)';

-- =============================================================================
-- DATOS SEMILLA · Turnos operativos típicos de una lavandería
-- =============================================================================

INSERT INTO turnos (nombre, hora_inicio, hora_fin) VALUES
    ('Turno mañana', '06:00:00', '14:00:00'),
    ('Turno tarde',  '14:00:00', '22:00:00');

-- =============================================================================
-- ROW LEVEL SECURITY · Configuración base para Supabase Auth
-- =============================================================================

ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE programas ENABLE ROW LEVEL SECURITY;
ALTER TABLE insumos ENABLE ROW LEVEL SECURITY;
ALTER TABLE programa_insumo ENABLE ROW LEVEL SECURITY;
ALTER TABLE ciclos ENABLE ROW LEVEL SECURITY;
ALTER TABLE movimientos_inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE notificaciones_stock ENABLE ROW LEVEL SECURITY;
ALTER TABLE dispositivos_push ENABLE ROW LEVEL SECURITY;

-- Política base: usuarios autenticados pueden leer todos los catálogos
CREATE POLICY pol_lectura_autenticados ON clientes
    FOR SELECT TO authenticated USING (TRUE);
CREATE POLICY pol_lectura_autenticados ON programas
    FOR SELECT TO authenticated USING (TRUE);
CREATE POLICY pol_lectura_autenticados ON insumos
    FOR SELECT TO authenticated USING (TRUE);
CREATE POLICY pol_lectura_autenticados ON programa_insumo
    FOR SELECT TO authenticated USING (TRUE);
CREATE POLICY pol_lectura_autenticados ON ciclos
    FOR SELECT TO authenticated USING (TRUE);

-- Política: el operario solo puede crear ciclos a su nombre
CREATE POLICY pol_operario_crea_ciclos ON ciclos
    FOR INSERT TO authenticated
    WITH CHECK (usuario_id = auth.uid());

-- Política: solo gerenciales pueden modificar catálogos
CREATE POLICY pol_gerencial_modifica_clientes ON clientes
    FOR ALL TO authenticated
    USING (EXISTS (SELECT 1 FROM usuarios WHERE id = auth.uid() AND rol = 'gerencial'));

CREATE POLICY pol_gerencial_modifica_programas ON programas
    FOR ALL TO authenticated
    USING (EXISTS (SELECT 1 FROM usuarios WHERE id = auth.uid() AND rol = 'gerencial'));

CREATE POLICY pol_gerencial_modifica_insumos ON insumos
    FOR ALL TO authenticated
    USING (EXISTS (SELECT 1 FROM usuarios WHERE id = auth.uid() AND rol = 'gerencial'));

-- =============================================================================
-- FIN DEL ESQUEMA
-- =============================================================================
