USE coderhouse_gamers;

SELECT *
FROM LEVEL_GAME;

SELECT *
FROM CLASS;


SELECT DISTINCT
   id_level
,  "new_level"
FROM staging_new_class_clone -- NEW class -- (tablas de staging)
WHERE id_level NOT IN (
   SELECT id_level
   FROM LEVEL_GAME
);

CREATE TABLE IF NOT EXISTS
  coderhouse_gamers.new_level_game (
  id_level INT NOT NULL,
  description VARCHAR(255) NOT NULL
);

-- voy a crear una tabla nueva
-- CREATE TABLE IN NOT EXISTS staging_new_class (
-- ); -- forma tradicional

-- forma A ESTRUCTURA SIN REGISTRO CON INDICES (sin datos pero con restrictores)
CREATE TABLE staging_new_class LIKE CLASS;

SELECT *
FROM staging_new_class;

-- forma B ESTRUCTURA CON DATOS SIN INDICES (con datos y sin indicies o restrictores)
CREATE TABLE staging_new_class_clone AS
   SELECT *
   FROM CLASS;

SELECT *
FROM staging_new_class_clone;

--  insertar valores en la nueva tabla staging
INSERT INTO staging_new_class_clone
VALUES
(20, 101, "Killer Queen"),
(21, 102, "Rol"),
(25, 103, "Counter Strike");

-- VOLCAR LA DATA EN LA NUEVA TABLA
INSERT INTO coderhouse_gamers.new_level_game (id_level, description)
   SELECT DISTINCT
   id_level
,  "new_level"
   FROM staging_new_class_clone -- NEW class -- (tablas de staging)
   WHERE id_level NOT IN (
      SELECT id_level
      FROM LEVEL_GAME 
);

SELECT *
FROM new_level_game;

-- VOLCAR A TABLA PRODUCTIVA

INSERT INTO LEVEL_GAME (id_level, description)
SELECT
   id_level
,  description 
FROM coderhouse_gamers.new_level_game;

SELECT *
FROM level_game;

-- ACTUALIZAR LA TABLA
-- ACTUALIZAR LOS PERMISOS PARA CAMBIO MASIVO
SET SQL_SAFE_UPDATES = 0;
UPDATE coderhouse_gamers.new_level_game
  SET id_level = 40
  WHERE id_level IN 
     ( 
     SELECT id_level
     FROM LEVEL_GAME 
     WHERE description LIKE "%new level%"
     );

-- CHALLENGE
CREATE TABLE IF NOT EXISTS advergame
   SELECT *
   FROM GAME
   LIMIT 1;

TRUNCATE TABLE advergame;

CREATE TABLE IF NOT EXISTS adverclass
   SELECT *
   FROM CLASS
   LIMIT 1;
   
TRUNCATE TABLE adverclass ;

-- INSERT DATA NUEVA
INSERT INTO advergame(id_game, name, description, id_level, id_class)
VALUES
(301,"KOF 97","JUEGO DE PELEA",50,400),
(302,"FIFA","FOOTBALL",51,401),
(303,"DIABLO","SCI FI",54,403),
(305, "WORMS","STRATEGY",55,410),
(307, "AGE OF EMPIRES","MISC",56,411)
;

INSERT INTO adverclass 
   SELECT *
   FROM CLASS ;
   
INSERT INTO adverclass 
   SELECT 
      id_level
   ,  id_class 
   ,  description 
   FROM advergame AS ag
   WHERE NOT EXISTS (
      SELECT 
--          id_level
--      ,   id_class
      1  -- busqueda booleana mas optima
      FROM GAME AS g
      WHERE (ag.id_level = g.id_level AND ag.id_class = g.id_class)
);

SELECT *
FROM adverclass;
