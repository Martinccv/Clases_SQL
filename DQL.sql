-- DQL -> DATA QUERY LANG.

USE coderhouse_gamers;

-- VIZ LAS TABLAS

SHOW TABLES ;

SELECT 
	* -- SELECTOR DE COLUMNAS
FROM coderhouse_gamers.SYSTEM_USER

-- traeme de la misma tabla solamente 10 records

explain analyze select
   *
from coderhouse_gamers.SYSTEM_USER
limit 10;

-- TRAEME LAS 1O CON SOLAMENTE NOMBRE Y DE EMAIL- FIRST_NAME::NOMBRE Y EMAIL::CORREO_ELECTRONICO

select 
    first_name as NOMBRE
,   email as CORREO_ELECTRONICO
from coderhouse_gamers.SYSTEM_USER 

-- TRAEME TODOS LOS USUARIOS QUE EMPIECEN EL NOMBRE CON M
-- columnas a traer
select 
    first_name as NOMBRE
,   email as CORREO_ELECTRONICO
-- de que tabla viene
from coderhouse_gamers.SYSTEM_USER
-- que filtros poner
where
   first_name like "M%"
and email     not like "%.com"
;


