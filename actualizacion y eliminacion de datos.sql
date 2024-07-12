-- CLASE 14
-- ACTUALIZACION Y ELIMINACION DE DATOS


**Título de la Clase: Fundamentos de Bases de Datos y MySQL**

**Introducción:**
En el mundo de las bases de datos, MySQL es una de las opciones más populares y poderosas para gestionar grandes conjuntos de datos. Uno de los aspectos fundamentales de cualquier base de datos es mantener la integridad de los datos almacenados. En esta clase, exploraremos cómo MySQL aborda este desafío, centrándonos en la integridad referencial, las restricciones y las acciones en cascada.

**1. Integridad Referencial en MySQL:**

   - **Concepto de Integridad Referencial:** La integridad referencial es la garantía de que las relaciones entre las tablas de una base de datos se mantengan consistentes.
   
   - **Implementación en MySQL:** MySQL ofrece soporte completo para la integridad referencial mediante el uso de claves foráneas y restricciones.

**2. Tipos de Integridad:**

   - **Integridad Débil:** Se refiere a la garantía de que no habrá valores nulos en una relación entre tablas.
   
   - **Integridad Parcial y Completada:** La integridad parcial se refiere a garantizar la consistencia de datos en una parte específica de la base de datos, mientras que la completada asegura la consistencia en toda la base de datos.

**3. Restricciones en MySQL:**

   - **Restricción de Unicidad:** Garantiza que no haya valores duplicados en una columna específica.
   
   - **Restricción de Valor No Nulo:** Obliga a que una columna no pueda tener valores nulos.
   
   - **Restricción de Clave Primaria:** Define una columna o conjunto de columnas como clave primaria, asegurando unicidad e integridad referencial.
   
   - **Restricción de Integridad Referencial:** Define relaciones entre tablas para mantener la integridad de los datos.

**4. Acciones en Cascada:**

   - **CASCADE:** Cuando se realiza una acción (eliminar o actualizar) en una fila de una tabla, las acciones en cascada propagan esa acción a las filas relacionadas en otras tablas.
   
   - **SET NULL:** Establece los valores de las columnas relacionadas en NULL cuando se realiza una acción en cascada.
   
   - **NO ACTION y RESTRICT:** Impiden la eliminación o actualización de filas en una tabla si existen restricciones de integridad referencial que podrían violarse.

**Conclusión:**
MySQL proporciona una variedad de herramientas para garantizar la integridad de los datos almacenados en una base de datos. Comprender cómo se implementan las restricciones y las acciones en cascada es fundamental para diseñar bases de datos eficientes y fiables. En esta clase, hemos explorado los fundamentos de la integridad referencial, los tipos de integridad, las restricciones y las acciones en cascada en MySQL, sentando las bases para un diseño robusto de bases de datos relacionales.





---
-- Ejemplo en vivo 
DROP DATABASE IF EXISTS integridad_referencial;
CREATE DATABASE integridad_referencial;
USE integridad_referencial;


-- Creamos la tabla "pais"
CREATE TABLE pais (
    cod_pais VARCHAR(10) NOT NULL,
    nombre VARCHAR(100),
    idioma VARCHAR(100),
    moneda VARCHAR(100),
    PRIMARY KEY(cod_pais)
) COMMENT "TABLA RELACIONADA A LA CREACION DE PAISES";


-- Creamos la tabla "ciudad" que referencia a la tabla "pais"
CREATE TABLE ciudad (
    cod_ciudad VARCHAR(10) NOT NULL,
    nombre_ciudad VARCHAR(100),
    cod_area VARCHAR(20),
    longitud DECIMAL(11,8),
    latitud DECIMAL(10,8),
--    pais_id INT DEFAULT 100,
    PRIMARY KEY (cod_ciudad)
 --    FOREIGN KEY (pais_id) REFERENCES pais(id)
 --       ON DELETE SET NULL
 --       ON UPDATE SET NULL
);


-- Creamos la tabla "ciudadanos" que referencia a la tabla "ciudad"
CREATE TABLE ciudadanos (
    cod_legajo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
    email VARCHAR(200),
    PRIMARY KEY (cod_legajo)
--    ciudad_id INT DEFAULT 100,
--    FOREIGN KEY (ciudad_id) REFERENCES ciudad(id)
--         ON DELETE SET DEFAULT
        -- ON UPDATE SET DEFAULT
--         ON UPDATE CASCADE
);

ALTER TABLE ciudad
   ADD COLUMN pais VARCHAR(100);

-- ALTER TABLE ciudad
--   DROP FOREIGN KEY fk_ciudad_pais;
  
ALTER TABLE ciudad
   ADD CONSTRAINT fk_ciudad_pais
   FOREIGN KEY (pais) REFERENCES pais(cod_pais)
   ON UPDATE CASCADE
   ON DELETE CASCADE
  ;
   
 ALTER TABLE ciudadanos
   ADD COLUMN cod_ciudad VARCHAR(10);
  
ALTER TABLE ciudadanos
   ADD CONSTRAINT fk_cuidadanos_cuidad
   FOREIGN KEY (cod_ciudad) REFERENCES ciudad(cod_ciudad)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
  
-- insertamos datos  
INSERT INTO pais (cod_pais, nombre, idioma, moneda) VALUES
('US', 'United States', 'English', 'US Dollar'),
('ES', 'Spain', 'Spanish', 'Euro'),
('FR', 'France', 'French', 'Euro'),
('JP', 'Japan', 'Japanese', 'Yen'),
('BR', 'Brazil', 'Portuguese', 'Brazilian Real'),
('IN', 'India', 'Hindi', 'Indian Rupee'),
('CN', 'China', 'Chinese', 'Renminbi'),
('DE', 'Germany', 'German', 'Euro'),
('MX', 'Mexico', 'Spanish', 'Mexican Peso'),
('IT', 'Italy', 'Italian', 'Euro');
  
INSERT INTO ciudad (cod_ciudad, nombre_ciudad, cod_area, longitud, latitud, pais) VALUES
('NYC', 'New York City', '212', -74.0060, 40.7128, 'US'),
('MAD', 'Madrid', '91', -3.7038, 40.4168, 'ES'),
('PAR', 'Paris', '1', 2.3522, 48.8566, 'FR'),
('TOK', 'Tokyo', '3', 139.6917, 35.6895, 'JP'),
('SAO', 'São Paulo', '11', -46.6333, -23.5505, 'BR'),
('DEL', 'Delhi', '11', 77.1025, 28.6139, 'IN'),
('BEJ', 'Beijing', '10', 116.4074, 39.9042, 'CN'),
('BER', 'Berlin', '30', 13.4050, 52.5200, 'DE'),
('MEX', 'Mexico City', '55', -99.1332, 19.4326, 'MX'),
('ROM', 'Rome', '6', 12.4964, 41.9028, 'IT');

INSERT INTO ciudadanos (nombre, email, cod_ciudad) VALUES
('John Doe', 'john.doe@example.com', 'NYC'),
('Jane Smith', 'jane.smith@example.com', 'MAD'),
('Alice Johnson', 'alice.johnson@example.com', 'PAR'),
('Bob Brown', 'bob.brown@example.com', 'TOK'),
('Carlos Martinez', 'carlos.martinez@example.com', 'SAO'),
('Priya Sharma', 'priya.sharma@example.com', 'DEL'),
('Li Wei', 'li.wei@example.com', 'BEJ'),
('Klaus Müller', 'klaus.mueller@example.com', 'BER'),
('Ana García', 'ana.garcia@example.com', 'MEX'),
('Giulia Rossi', 'giulia.rossi@example.com', 'ROM');

-- integridad referencial

UPDATE pais
   SET nombre ="MEJICO"
   WHERE cod_pais="MX";

UPDATE pais
   SET cod_pais ="MJ"
   WHERE cod_pais="MX";  

DELETE FROM pais
   WHERE cod_pais = "CN"
  
SELECT *
FROM pais;

SELECT *
FROM ciudad;

SELECT *
FROM ciudadanos
JOIN ciudad AS c USING(cod_ciudad)
JOIN pais AS p ON p.cod_pais = c.pais
  WHERE cod_pais ="MX";

-- Ahora, vamos a actualizar una ciudad en la tabla "ciudad"
DELETE FROM pais
   WHERE cod_pais = 1 ; 


UPDATE pais SET cod_pais = 9 WHERE cod_pais = 1;

UPDATE pais SET cod_pais = DEFAULT WHERE cod_pais = 3;

UPDATE ciudad SET cod_ciudad = 4 WHERE cod_ciudad = 102;
UPDATE ciudad SET cod_ciudad = DEFAULT WHERE cod_ciudad = 4;


-- Mostramos los resultados
SELECT * FROM ciudadanos;