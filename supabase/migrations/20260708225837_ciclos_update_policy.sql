-- Corrige HU-02.4: el operario no podía cerrar su ciclo porque `ciclos` tiene
-- RLS habilitado con políticas de SELECT e INSERT pero ninguna de UPDATE, por
-- lo que el UPDATE de cierre afectaba 0 filas de forma silenciosa.
-- El operario solo puede actualizar sus propios ciclos.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'ciclos' AND policyname = 'pol_operario_actualiza_sus_ciclos'
  ) THEN
    CREATE POLICY pol_operario_actualiza_sus_ciclos ON ciclos
        FOR UPDATE TO authenticated
        USING (usuario_id = auth.uid())
        WITH CHECK (usuario_id = auth.uid());
  END IF;
END $$;
