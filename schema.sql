-- Drop the table if it already exists to ensure a clean setup.
-- This allows the script to be run multiple times without errors.
DROP TABLE IF EXISTS public.air_quality;

-- Create the main table to hold the air quality data.
-- Data types are chosen carefully:
-- TIMESTAMP for date and time data.
-- NUMERIC(15, 8) for decimal values to ensure precision without overflow.
CREATE TABLE public.air_quality (
    datetime      TIMESTAMP,
    aqi           NUMERIC(15, 8),
    pm2_5         NUMERIC(15, 8),
    pm10          NUMERIC(15, 8),
    o3            NUMERIC(15, 8),
    no2           NUMERIC(15, 8),
    so2           NUMERIC(15, 8),
    co            NUMERIC(15, 8),
    temperature   NUMERIC(15, 8),
    humidity      NUMERIC(15, 8),
    wind_speed    NUMERIC(15, 8),
    pressure      NUMERIC(15, 8)
);