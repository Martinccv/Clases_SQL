DROP DATABASE IF EXISTS inmobiliaria_db;

CREATE DATABASE IF NOT EXISTS inmobiliaria_db;

USE inmobiliaria_db;

-- crear tabla inquilino con sus correspondientes caracteristicas
CREATE TABLE inquilino(
   id_inquilino INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nombre VARCHAR(60),
   email VARCHAR(100) NOT NULL UNIQUE,
   fecha_asociado DATE DEFAULT (CURRENT_DATE) COMMENT "SE PUEDE GENERAR NULLS O CREAR DE MANERA MANUAL O DEFAULT"
)
   COMMENT "tabla definida para el uso de la inmobiliaria"
;

-- MODIFICAR LA TABLA AGREGANDO UNA COLUMNA NUEVA
ALTER TABLE inmobiliaria_db.inquilino
  ADD COLUMN tiene_garante BOOLEAN NOT NULL DEFAULT TRUE
  AFTER nombre;
--  BORRO COLUMNA NUEVA
 ALTER TABLE inmobiliaria_db.inquilino
  DROP COLUMN tiene_garante;
-- CREO NUEVAMENTE COLUMNA PERO AGREGO COMENTARIOS
 ALTER TABLE inmobiliaria_db.inquilino
  ADD COLUMN tiene_garante BOOLEAN NOT NULL DEFAULT TRUE COMMENT "SIEMPRE DEBERIA TENER GARANTE"
  AFTER nombre;
 
-- mostrar todas las columnas de la tabla
SHOW FULL COLUMNS FROM inmobiliaria_db.inquilino;

-- mostrar los comentarios y esquemas de las tablas
SELECT
TABLE_NAME
, TABLE_SCHEMA
, TABLE_COMMENT
FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = "inmobiliaria_db";

-- TRATEN DE AGREGAR ATRIBUTOS A LAS SIGUIENTES TABLAS
   
CREATE TABLE dueno();

CREATE TABLE contrato();

CREATE TABLE propiedad();

-- CLONADO DE TABLAS
CREATE TABLE inmobiliaria_db.COPY_CLASS
LIKE coderhouse_gamers.CLASS;

SHOW TABLES ;

SELECT * 
FROM inmobiliaria_db.COPY_CLASS;

-- TRAER TABLAS DE OTRAS BASES DE DATOS
CREATE TABLE inmobiliaria_db.STAGING_CLASS_TWO
   AS (
       SELECT 
           description
       FROM coderhouse_gamers.CLASS
   );
   
SELECT *
FROM inmobiliaria_db.staging_class_two;

-- CREAR TABLA TEMPORARIA, SE ELIMINA AL CERRAR SESION
CREATE TEMPORARY TABLE inmobiliaria_db.TEMPORARY
   AS (
       SELECT 
           description
       FROM coderhouse_gamers.CLASS
  );
  
 SELECT *
FROM inmobiliaria_db.TEMPORARY;
