-- LINK  : https://www.prisma.io/dataguide/mysql/inserting-and-modifying-data/inserting-and-deleting-data
-- INFORMACION OFICIAL : 
-- INSERT >> https://dev.mysql.com/doc/refman/8.0/en/insert.html
-- UPDATE >> https://dev.mysql.com/doc/refman/8.0/en/update.html
-- DELETE >> https://dev.mysql.com/doc/refman/8.0/en/delete.html


1. **SELECT**: 
Si bien esta dentro de la definicion de DML >> es considerado mas como parte del DQL (Data query language)

   ```sql
   SELECT * FROM empleados WHERE departamento = 'Ventas';
   ```

2. **INSERT**:
   ```sql
   INSERT INTO clientes (nombre, correo) VALUES ('Juan Pérez', 'juan@example.com');
   ```

3. **UPDATE**:
   ```sql
   UPDATE productos SET precio = 25.99 WHERE id = 123;
   ```

4. **DELETE**:
   ```sql
   DELETE FROM pedidos WHERE estado = 'cancelado';
   ```

5. **MERGE**:  
--  Tambien es parte del sublenguaje, sin embargo no es de uso comun en MySQL 
--  UPSERT es algo comunmente usado en PosgreSQL 
--  ON UPDATE >> https://www.mysqltutorial.org/mysql-basics/mysql-insert-or-update-on-duplicate-key-update/
   MySQL no tiene un comando MERGE incorporado, pero se puede lograr utilizando combinaciones de INSERT y UPDATE.

   Ejemplo de combinación de INSERT y UPDATE para MySQL:
   ```sql
   INSERT INTO ventas (producto_id, cantidad)
   SELECT source.producto_id, source.cantidad
   FROM nuevos_datos AS source
   LEFT JOIN ventas AS target 
    ON source.producto_id = target.producto_id
    ON DUPLICATE KEY UPDATE cantidad = source.cantidad;
   ```
   En este ejemplo, los nuevos datos se insertan en la tabla "ventas", y si hay una clave duplicada (en este caso, "producto_id"), se actualiza la cantidad en lugar de insertar un nuevo registro.

Estos son los mismos ejemplos adaptados para MySQL, que es una implementación común de SQL en entornos de bases de datos.


-- IE 
DROP DATABASE IF EXISTS CLASE11;
CREATE DATABASE CLASE11;
USE CLASE11;


CREATE TABLE empleado (
    id_empleado INT NOT NULL AUTO_INCREMENT ,
    nombre VARCHAR(60) DEFAULT 'EMPLEADO SIN NOMBRE',
    status_empleado BOOLEAN DEFAULT TRUE,
    salario DECIMAL(10,2) DEFAULT 6500000.00,
    fecha_alta DATE DEFAULT (CURRENT_DATE),
    observacion TEXT ,

    -- PRIMARY KEY

    PRIMARY KEY(id_empleado)
);


SELECT
    *
FROM CLASE11.empleado;

-- INSERT RECORDS
    -- INSERCION FULL COLUMNAS
INSERT  INTO
        CLASE11.empleado
        VALUES
        (1,'MANUEL',TRUE,185000.10,'2024-02-27','me falto darlo de alta');
        
INSERT  INTO
        CLASE11.empleado (id_empleado, nombre,status_empleado,salario,fecha_alta)
        VALUES
        (2,'LUCIANO',NULL,DEFAULT,'2024-02-27');

INSERT  INTO
        CLASE11.empleado (id_empleado, nombre,status_empleado,fecha_alta,salario)
        VALUES
        (NULL,'LUCIANO',DEFAULT,'2024-02-27',DEFAULT);
        
-- INSERCION PARCIAL

INSERT  INTO
        CLASE11.empleado (observacion)
        VALUES
        ('todos los campos tienen valor por default');


INSERT INTO 
    CLASE11.empleado 
    (nombre, status_empleado, salario, observacion) 
    VALUES 
('Bayard', true, 442305.49, 'KT1MXGz2GPDNqULx7tBSQQ1X81yMnoxaWYyH'),
('Tracy', false, 175175.56, 'KT1HhhbaUU8ZVthBJJGEVSMqEDpApqFbevuT'),
('Iseabal', true, 754585.25, 'KT1KGGNQxgV3yzJMY2VUPa4CimZXpVSriCK7'),
('Son', false, 592234.15, 'KT1AxkQGDGY9e4BCKjCZ9PmSebhZdSTee3MR'),
('Drucill', false, 256500.1, 'KT1SbfZVs3M1M8TCxnPrEBPKLff9avyBd9tY'),
('Samantha', false, 917732.22,  'KT1D2xaP5cD2aeoFcmCqyUskddSdqQWMiBMT'),
('Zorine', true, 876629.21,  'KT1RXjKGhnfjUh5ZQ8766RxdJFu6pgEd2JQM'),
('Dominique', false, 530584.93, 'KT1DroXCRqZPyd2TqVJP8SkdmcF8Ccet1MPJ'),
('Danita', false, 108934.04,  'KT1X3FANyjsM2ArDq8TqMB88tvBbQgrb58vo'),
('Nealy', false, 444861.13,  'KT1TS45vAQDq9vJkJfZPZJMPK5FC6DxJYZ1o'),
('Hazel', null, 854803.29,  'KT1JPdBT7wrnebvgQrPzEaTU6KYtWYjeo9b3');

-- UPDATE RECORDS

SET SQL_SAFE_UPDATES = FALSE ; -- PERMITIR QUE SE PUEDA HACER ESTAS UPDATES DE MANERA MASIVA SIN TENER EL SAFE DE MYSQL

UPDATE CLASE11.empleado
    SET status_empleado = FALSE;

    -- ACTUALIZADO UNICO
    -- ACTUALIZADO MASIVO

UPDATE CLASE11.empleado
    SET 
        status_empleado =   1
    ,   fecha_alta      =   '1987-10-10'
WHERE 
    nombre LIKE 'D%';


-- ejemplo de la filmina : 
-- Si deseamos actualizar los niveles de las clases de juegos,
-- pasar a nivel 8 todas las clases que están entre la 1 y la 20 inclusive  
-- y cuyos niveles actuales están por debajo del 13

SELECT
 *
FROM coderhouse_gamers.GAME
WHERE TRUE
    AND id_class BETWEEN 1  AND 20
    AND id_level < 13
;


-- ¿Cuántos registros se actualizarían y Cuál sería la cláusula UPDATE?

SELECT * 
FROM coderhouse_gamers.GAME
WHERE id_game IN (55,57,8,93,23);

-- EN UN PRINCIPIO NO SE PODRIA POR UN TEMA DE INTEGRIDAD 
-- REFERENCIAL

UPDATE coderhouse_gamers.GAME
    SET id_level = 8
WHERE   TRUE
        AND id_class BETWEEN 1 AND 20
        AND id_level < 13 ; 

-- DESABILITANDO LA OPCION DE INTEGRIDAD

SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

-- AL CORRER NUEVAMENTE LA QUERY SE ACTUALIZARA UNA CANTIDAD DETERMINADA

-- DELETE | LOGICAL DELETE
DELETE FROM coderhouse_gamers.GAME; -- se borran todos los registros pero NO resetea la tabla
SELECT  * FROM   coderhouse_gamers.GAME;


DELETE FROM CLASE11.empleado
    WHERE   TRUE
            AND status_empleado = FALSE;
           
TRUNCATE TABLE CLASE11.empleado; -- para resetear la tabla a 0
        
SELECT 
    *  
FROM CLASE11.empleado;

-- ejemplo de clases
DROP DATABASE IF EXISTS CLASE11;
CREATE DATABASE CLASE11;
USE CLASE11;

CREATE TABLE empleado (
    id_empleado INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) DEFAULT 'EMPLEADO SIN NOMBRE',
    email  VARCHAR(100) UNIQUE NOT NULL,
    status_empleado BOOLEAN DEFAULT TRUE,
    salario DECIMAL(10,2) DEFAULT 6500000.99,
    fecha_alta DATE DEFAULT (CURRENT_DATE), -- 'yyyy-mm-dd'
    observacion TEXT ,
    -- PRIMARY KEY
    PRIMARY KEY(id_empleado)
);


-- INSERT INTO

INSERT INTO CLASE11.empleado
(id_empleado,
nombre,
status_empleado,
salario,
fecha_alta,
observacion,
email)
VALUES
(1,
"Guille Chiantore",
True,
100000,
'2024-10-10',
"Es un buen amigo",
"guille_chian@mail.com");

-- 
INSERT INTO CLASE11.empleado
(id_empleado,
nombre,
email,
status_empleado,
salario,
fecha_alta,
observacion
)
VALUES
(NULL,"pepe-sanki","pepe@mail.com",False,900000,current_date,"delantero");


INSERT INTO CLASE11.empleado
(nombre,
email,
status_empleado,
salario,
fecha_alta,
observacion
)
VALUES
("miyagi","mayagi@mail.com",True,800000,current_date,"maestro"),
("totoro","totoro@mail.com",False,700000,current_date,"dios de la muerte"),
("banana pueyrredon","cesar@mail.com",True,7000000,current_date,"gran cantante");


INSERT INTO CLASE11.empleado
(nombre,
email,
status_empleado,
salario,
fecha_alta,
observacion
)
VALUES
("miyagi-san","mayagi@mail.com",True,800000,current_date,"maestro");

SELECT
    *
FROM CLASE11.empleado;


INSERT INTO CLASE11.empleado
(nombre,
email,
status_empleado,
salario,
fecha_alta,
observacion
)
VALUES (DEFAULT,"usuario_x@mail.com",DEFAULT,DEFAULT,DEFAULT,"este es un empleado nuevo");

INSERT INTO CLASE11.empleado
(email,observacion)
VALUES
("nuevo_mail@mail.com","registro sin los otros campos");


-- insercion masiva con datos default

INSERT INTO CLASE11.empleado
(nombre, email, observacion) 
VALUES 
('Whitby', 'wsurby0@miitbeian.gov.cn', 'Malagasy'),
('Hyacinth', 'hstentiford1@craigslist.org', 'Khmer'),
('Murial', 'mbidwell2@skyrock.com', 'Tajik'),
('Nolan', 'nasken3@taobao.com', 'Tswana'),
('Gavan', 'gandreasson4@yelp.com', 'Chinese'),
('Koressa', 'kluce5@intel.com', 'French'),
('Dorian', 'dfergie6@eventbrite.com', 'Mongolian'),
('Bernard', 'balsobrook7@webnode.com', 'Gujarati'),
('Luca', 'lmawby8@51.la', 'Fijian'),
('Gay', 'gcockshutt9@time.com', 'Punjabi'),
('Brett', 'beilhermanna@yolasite.com', 'Tajik'),
('Horten', 'hheeranb@mapquest.com', 'Catalan'),
('Daniel', 'dbonusc@pagesperso-orange.fr', 'Oriya'),
('Arthur', 'aprendergrassd@hostgator.com', 'Korean'),
('Neils', 'nscoggine@forbes.com', 'Dhivehi'),
('Daniele', 'dosuairdf@joomla.org', 'Norwegian'),
('Merell', 'mkornelg@admin.ch', 'Bengali'),
('Jozef', 'jwallh@google.cn', 'German'),
('Wilhelm', 'wfeirni@state.tx.us', 'Moldovan'),
('Zarla', 'zkealeyj@mit.edu', 'Dutch'),
('Sandy', 'sphettek@businesswire.com', 'Icelandic'),
('Forester', 'ftalmanl@flickr.com', 'Kazakh'),
('Frankie', 'fvannim@posterous.com', 'Chinese'),
('Venus', 'vbendixn@state.gov', 'Pashto'),
('Celle', 'cvaneedeno@illinois.edu', 'Somali'),
('Marlo', 'mbebisp@umn.edu', 'Swati'),
('Eugenie', 'ecaponq@forbes.com', 'Hungarian'),
('Lillis', 'ltappr@mayoclinic.com', 'Luxembourgish'),
('Dagmar', 'ddys@cnet.com', 'Ndebele'),
('Buiron', 'bewlest@altervista.org', 'Malayalam'),
('Aurthur', 'alangeu@ibm.com', 'Maltese'),
('Blinny', 'bskipperv@un.org', 'Croatian'),
('Zulema', 'zdiruggerow@squidoo.com', 'Italian'),
('Francine', 'fgoodreadx@harvard.edu', 'Persian'),
('Eldon', 'edalescoy@nbcnews.com', 'Fijian'),
('Shela', 'stownsendz@qq.com', 'Gagauz'),
('Felix', 'fsheaf10@vinaora.com', 'Bosnian'),
('Mindy', 'mgetcliffe11@last.fm', 'Albanian'),
('Blaine', 'byerrington12@usgs.gov', 'Quechua'),
('Wilton', 'wrosenau13@psu.edu', 'Malay'),
('Rolfe', 'rbeade14@twitter.com', 'Afrikaans'),
('Yancy', 'ygeary15@bbc.co.uk', 'Portuguese'),
('Agnes', 'awilliam16@nih.gov', 'Polish'),
('Madeline', 'mhawkridge17@a8.net', 'Tsonga'),
('Sinclare', 'sconduit18@google.co.jp', 'Latvian'),
('Alfons', 'aprahl19@wired.com', 'Assamese'),
('Alexa', 'alotherington1a@wordpress.org', 'Pashto'),
('Glynda', 'ggallant1b@cloudflare.com', 'Spanish'),
('Humfrey', 'hglanvill1c@ed.gov', 'Czech'),
('Bren', 'bflaune1d@ezinearticles.com', 'Nepali'),
('Crichton', 'ckonrad1e@senate.gov', 'Malagasy'),
('Madeleine', 'mgorham1f@utexas.edu', 'Malayalam'),
('Brunhilde', 'bbrayshaw1g@xinhuanet.com', 'Georgian'),
('Trumann', 'tbooton1h@weibo.com', 'Tamil'),
('Deidre', 'dfelipe1i@vinaora.com', 'Oriya'),
('Natassia', 'nstovine1j@angelfire.com', 'Kashmiri'),
('Myca', 'mragless1k@cargocollective.com', 'Finnish'),
('Dore', 'dwimlett1l@xinhuanet.com', 'Zulu'),
('Rosa', 'rcromblehome1m@newyorker.com', 'Belarusian'),
('Darrin', 'dpoon1n@yahoo.co.jp', 'Tajik'),
('Kristin', 'kduggen1o@umich.edu', 'Luxembourgish'),
('Joyce', 'jdulinty1p@phoca.cz', 'Japanese'),
('Phylis', 'psenogles1q@tripod.com', 'Hebrew'),
('Tonnie', 'tladdle1r@npr.org', 'Afrikaans'),
('Radcliffe', 'rleeb1s@yale.edu', 'Luxembourgish'),
('Dani', 'dmcmillan1t@mapquest.com', 'Maltese'),
('Tobias', 'tbullene1u@ca.gov', 'Bulgarian'),
('Kylie', 'kwheildon1v@blogspot.com', 'Czech'),
('Kamilah', 'ksaville1w@census.gov', 'Hindi'),
('Ximenes', 'xmurthwaite1x@ted.com', 'Oriya'),
('Krysta', 'kcarbett1y@mapy.cz', 'Quechua'),
('Egon', 'ewyrall1z@vinaora.com', 'Papiamento'),
('Margalo', 'mmerrill20@washingtonpost.com', 'Macedonian'),
('Dani', 'dbeddow21@t-online.de', 'Italian'),
('Lil', 'lchaulk22@ed.gov', 'Bosnian'),
('Jennifer', 'jprendergast23@gnu.org', 'Tok Pisin'),
('Liliane', 'lmacalester24@sina.com.cn', 'Sotho'),
('Thorn', 'twildman25@eventbrite.com', 'Bulgarian'),
('Priscella', 'pfilippozzi26@oracle.com', 'Catalan'),
('Silvain', 'smunks27@github.io', 'Maltese'),
('Silvana', 'sblose28@yelp.com', 'Romanian'),
('Vale', 'vwhopples29@sourceforge.net', 'Arabic'),
('Maiga', 'mkinrade2a@vimeo.com', 'Maltese'),
('Ashli', 'agreensmith2b@drupal.org', 'Italian'),
('Immanuel', 'imecchi2c@domainmarket.com', 'Telugu'),
('Mar', 'mhaffner2d@cmu.edu', 'Latvian'),
('Jonathon', 'jbonar2e@deliciousdays.com', 'Czech'),
('Cherilynn', 'cputterill2f@ucoz.ru', 'Hindi'),
('Perrine', 'pgarahan2g@wikipedia.org', 'Hiri Motu');


-- 
-- UPDATE
UPDATE CLASE11.empleado
	SET 
		salario = 4000000 ,
        observacion = "ya sos un tipo que tiene status senior"
    WHERE email LIKE "guille_chian@mail.com";


SET SQL_SAFE_UPDATES = FALSE;


UPDATE CLASE11.empleado
	SET
		salario = 2000
	WHERE
		email LIKE '%.com';

-- DELETE
DELETE FROM CLASE11.empleado
WHERE nombre LIKE 'm%';


TRUNCATE TABLE CLASE11.empleado;


-- Bibliografia adicional 
-- https://www.linkedin.com/pulse/sargable-vs-non-query-md-mehedi-hasan/

SARGABLE QUERIES

- Avoid using functions or calculations on indexed columns in the WHERE clause.
- Use direct comparisons when possible, instead of wrapping the column in a function.
- If we need to use a function on a column, consider creating a computed column or a function-based index, if the database system supports it.