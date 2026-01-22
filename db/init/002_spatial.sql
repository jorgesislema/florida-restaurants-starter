-- 002_spatial.sql
-- Añadimos columna geom derivada y un índice espacial para queries geográficas
ALTER TABLE dim_restaurant
  ADD COLUMN IF NOT EXISTS geom POINT SRID 4326 GENERATED ALWAYS AS (ST_SRID(POINT(longitude, latitude),4326)) STORED,
  ADD SPATIAL INDEX IF NOT EXISTS idx_dim_restaurant_geom (geom);
