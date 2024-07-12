SHOW DATABASES;
USE coderhouse_gamers
;


-- TODOS LOS COMENTARIOS SOBRE JUEGOS DESDE EL 2019 EN ADELANTE

SELECT 
   commentary
,  comment_date 
   FROM coderhouse_gamers.COMMENTARY
WHERE
   comment_date > "2019-01-01"
;



-- TODOS LOS COMENTARIOS ENTRE 2011 - 2019

SELECT 
   commentary
,  comment_date 
   FROM coderhouse_gamers.COMMENTARY
WHERE
   comment_date BETWEEN "2011-01-01" AND "2019-01-01"
ORDER BY comment_date DESC 
;

-- JUEGOS QUE TENGAN NIVEL 15 -> 9 -> 5

SELECT 
*
FROM coderhouse_gamers.GAME
WHERE 
   -- id_level = 15
   -- OR id_level = 9
   -- OR id_level = 5
id_level IN (15,9,5)
;

-- JUEGOS DONDE TENGAN:
--   - Riders Republic
--   - The Dark Pictures: House Of Ashes
SELECT 
*
FROM coderhouse_gamers.GAME AS g
WHERE
   name LIKE "%Riders Republic%" 
   OR name LIKE "%The Dark Pictures: House Of Ashes%"
 ;

-- AGG FUNCTIONS

-- QUISIERA SABER EL CONTEO DE USUARIOS EN UNA TABLA DE JUEGOS

-- VOTE
SELECT
   id_system_user
,  COUNT(id_system_user) AS CANTIDAD_USUARIOS

FROM coderhouse_gamers.VOTE
GROUP BY id_system_user
ORDER BY cantidad_usuarios DESC;

SELECT 
 *
 FROM  coderhouse_gamers.PLAY;

-- DAME LA CANTIDAD DE USUARIOS COMPLETARON CADA JUEGO Y QUE CANTIDAD NO COMPLETO
-- CANTIDAD DE USUARIOS JUEGOS COMPLETADOS Y NO COMPLETADOS
-- : 1 , 1 cant_usuarios
-- : 1 , 0 cant_usuarios

SELECT 
   id_game
,  IF (completed =1, "completado","no completado") AS status
,  COUNT(id_system_user) AS total_usuarios
FROM coderhouse_gamers.PLAY
GROUP BY id_game , completed
HAVING COUNT(id_system_user) > 7
;

-- VOTE EL VALOR SUM (VALUE)

SELECT
   *
FROM coderhouse_gamers.VOTE
LIMIT 10
;

-- MARKETING ME PIDE LOS JUEGOS MENOS RANKEADOS
-- LOS QUE TENGAN UN PROMEDIO POR DEBAJO DE 3

SELECT
    id_game
,   AVG(value) AS PROMEDIO_VOTACION

FROM coderhouse_gamers.VOTE
GROUP BY id_game
HAVING AVG(value) < 3
ORDER BY PROMEDIO_VOTACION
;

-- NOMBRE DEL JUEGO
-- EN LA TABLA GAME

SELECT
    v.id_game
,   g.name
,   AVG(v.value) AS PROMEDIO_VOTACION

FROM coderhouse_gamers.VOTE AS v
JOIN coderhouse_gamers.GAME AS g
   ON v.id_game = g.id_game 

GROUP BY v.id_game
HAVING AVG(v.value) < 3
ORDER BY PROMEDIO_VOTACION
;
