-- Habilita Supabase Realtime para el dashboard gerencial (HU-04.1, Sprint 3)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'ciclos'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.ciclos;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'insumos'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.insumos;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'notificaciones_stock'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.notificaciones_stock;
  END IF;
END $$;
