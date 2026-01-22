-- 001_schema.sql
-- Esquema base de tablas dimensión y hechos iniciales
-- Creamos tablas idempotentes para permitir re-ejecución en entornos locales

CREATE TABLE IF NOT EXISTS dim_restaurant (
  rest_id VARCHAR(64) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  latitude DOUBLE NOT NULL,
  longitude DOUBLE NOT NULL,
  state CHAR(2) NOT NULL,
  city VARCHAR(120) NULL,
  zip CHAR(5) NULL,
  cuisine VARCHAR(120) NULL,
  price_level TINYINT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS dim_source_link (
  rest_id VARCHAR(64) NOT NULL,
  source VARCHAR(32) NOT NULL,
  source_id VARCHAR(128) NOT NULL,
  name_raw VARCHAR(255) NULL,
  address_raw VARCHAR(255) NULL,
  PRIMARY KEY(rest_id, source, source_id),
  CONSTRAINT fk_source_rest FOREIGN KEY (rest_id) REFERENCES dim_restaurant(rest_id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS fct_reviews_daily (
  rest_id VARCHAR(64) NOT NULL,
  date DATE NOT NULL,
  source VARCHAR(32) NOT NULL,
  reviews_count INT NULL,
  rating_avg DECIMAL(3,2) NULL,
  PRIMARY KEY (rest_id, date, source),
  CONSTRAINT fk_reviews_rest FOREIGN KEY (rest_id) REFERENCES dim_restaurant(rest_id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
