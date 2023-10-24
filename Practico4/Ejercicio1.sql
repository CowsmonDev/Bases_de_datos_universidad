set search_path = "unc_250359";
-- Ejercicio3 Practico 3

DROP TABLE IF EXISTS Articulos_CONTIENE;
DROP TABLE IF EXISTS Articulos_PALABRA;
DROP TABLE IF EXISTS Articulos_ARTICULO;

CREATE TABLE IF NOT EXISTS Articulos_ARTICULO
(
    id_articulo  SERIAL PRIMARY KEY,
    titulo       VARCHAR(50) NOT NULL,
    autor        VARCHAR(50),
    fecha_pub    DATE,
    nacionalidad VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Articulos_CONTIENE
(
    id_articulo  INT,
    idioma       VARCHAR(50),
    cod_palabra  INT,
    nro_secction INT,
    PRIMARY KEY (id_articulo, idioma, cod_palabra)
);

CREATE TABLE IF NOT EXISTS Articulos_PALABRA
(
    cod_palabra SERIAL,
    idioma      VARCHAR(50),
    descripcion VARCHAR(50),
    PRIMARY KEY (cod_palabra, idioma)
);

ALTER TABLE Articulos_CONTIENE
    ADD CONSTRAINT fk_contiene_articulo FOREIGN KEY (id_articulo) REFERENCES Articulos_ARTICULO (id_articulo),
    ADD CONSTRAINT fk_contiene_palabra FOREIGN KEY (cod_palabra, idioma) REFERENCES Articulos_PALABRA (cod_palabra, idioma);


-- a) Controlar que las nacionalidades sean 'Argentina' 'Español' 'Inglesa' 'Alemana' o 'Chilena'.
-- b) Para las fechas de publicaciones se debe considerar que sean fechas posteriores o iguales al 2010.
-- c) Los artículos publicados luego del año 2020 deben ser solamente de nacionalidad ‘Argentina’.
-- d) Los artículos pueden tener como máximo 15 palabras claves
-- e) Sólo se pueden publicar artículos argentinos que contengan hasta 10 palabras claves.

-- a) y b)
ALTER TABLE articulos_articulo
    ADD CONSTRAINT ck_nacionalidad CHECK (nacionalidad IN ('Argentina', 'Español', 'Inglesa', 'Alemana', 'Chilena')),
    ADD CONSTRAINT ck_fecha_pub CHECK (fecha_pub >= to_date('01-01-2010', 'DD-MM-YYYY'));

-- probando a) y b)

INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
VALUES ('titulo1', 'autor1', '01-01-2010', 'Argentina');
INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
VALUES ('titulo2', 'autor2', '01-01-2010', 'Español');
INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
VALUES ('titulo3', 'autor3', '01-01-2010', 'Inglesa');
INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
VALUES ('titulo4', 'autor4', '01-01-2010', 'Alemana');
INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
VALUES ('titulo5', 'autor5', '01-01-2010', 'Chilena');

-- error de nacionalidad [ok]
--INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad) VALUES ('titulo5', 'autor5', '01-01-2010', 'ESPAÑA');
-- error de fecha [ok]
--INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad) VALUES ('titulo5', 'autor5', '01-01-2000', 'Chilena');

-- funciona correctamente


-- c) Los artículos publicados luego del año 2020 deben ser solamente de nacionalidad ‘Argentina’.
ALTER TABLE articulos_articulo
    ADD CONSTRAINT ck_fecha_pub_nacionalidad CHECK (fecha_pub >= to_date('01-01-2020', 'DD-MM-YYYY') AND
                                                    nacionalidad = 'Argentina');

-- d) Los artículos pueden tener como máximo 15 palabras claves
ALTER TABLE articulos_contiene
    ADD CONSTRAINT ck_cant_palabras_claves CHECK (
        NOT EXISTS (SELECT id_articulo, idioma, count(*) as cant_palabras_claves
                    FROM articulos_contiene
                    GROUP BY id_articulo, idioma
                    HAVING count(*) > 15)
        );

-- Reimplementacion de d) con triggers

CREATE OR REPLACE FUNCTION check_cant_palabras_claves()
    RETURNS TRIGGER AS
$$
    DECLARE cant_palabras_claves INTEGER;
    BEGIN
        SELECT count(*) INTO cant_palabras_claves
        FROM articulos_contiene
        WHERE id_articulo = NEW.id_articulo;

        IF cant_palabras_claves >= 15 THEN
            RAISE EXCEPTION 'El articulo no puede tener mas de 15 palabras claves';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_cant_palabras_claves
    BEFORE INSERT OR UPDATE OF id_articulo ON articulos_contiene
    FOR EACH ROW
    EXECUTE PROCEDURE check_cant_palabras_claves();

-- probando d)

-- eliminando datos previos:
DELETE FROM articulos_contiene WHERE TRUE;

DELETE FROM articulos_articulo WHERE TRUE;
ALTER SEQUENCE articulos_articulo_id_articulo_seq RESTART WITH 1;

DELETE FROM articulos_palabra WHERE TRUE;
ALTER SEQUENCE articulos_palabra_cod_palabra_seq RESTART WITH 1;

-- insertar 2 articulos
INSERT INTO articulos_articulo (titulo, autor, fecha_pub, nacionalidad)
    VALUES ('titulo1', 'autor1', '01-01-2010', 'Argentina'), ('titulo2', 'autor2', '01-01-2010', 'Argentina'), ('titulo3', 'autor3', '01-01-2010', 'Argentina');

SELECT * FROM articulos_articulo;

-- insertar 20 palabras claves en palabra
INSERT INTO articulos_palabra (cod_palabra, idioma, descripcion)
    VALUES (1, 'español', 'palabra1'), (2, 'español', 'palabra2'), (3, 'español', 'palabra3'), (4, 'español', 'palabra4'),
           (5, 'español', 'palabra5'), (6, 'español', 'palabra6'), (7, 'español', 'palabra7'), (8, 'español', 'palabra8'),
           (9, 'español', 'palabra9'), (10, 'español', 'palabra10'), (11, 'español', 'palabra11'), (12, 'español', 'palabra12'),
           (13, 'español', 'palabra13'), (14, 'español', 'palabra14'), (15, 'español', 'palabra15'), (16, 'español', 'palabra16'),
           (17, 'español', 'palabra17'), (18, 'español', 'palabra18'), (19, 'español', 'palabra19'), (20, 'español', 'palabra20');

SELECT * FROM articulos_palabra;

-- insertar 14 palabras claves para el articulo 1
INSERT INTO articulos_contiene (id_articulo, idioma, cod_palabra, nro_secction)
    VALUES (1, 'español', 1, 1), (1, 'español', 2, 2), (1, 'español', 3, 3), (1, 'español', 4, 4),
           (1, 'español', 5, 5), (1, 'español', 6, 6), (1, 'español', 7, 7), (1, 'español', 8, 8),
           (1, 'español', 9, 9), (1, 'español', 10, 10), (1, 'español', 11, 11), (1, 'español', 12, 12),
           (1, 'español', 13, 13), (1, 'español', 14, 14);

SELECT * FROM articulos_contiene WHERE id_articulo = 1;

-- insertar 15 palabras claves para el articulo 2
INSERT INTO articulos_contiene (id_articulo, idioma, cod_palabra, nro_secction)
    VALUES (2, 'español', 1, 1), (2, 'español', 2, 2), (2, 'español', 3, 3), (2, 'español', 4, 4),
           (2, 'español', 5, 5), (2, 'español', 6, 6), (2, 'español', 7, 7), (2, 'español', 8, 8),
           (2, 'español', 9, 9), (2, 'español', 10, 10), (2, 'español', 11, 11), (2, 'español', 12, 12),
           (2, 'español', 13, 13), (2, 'español', 14, 14), (2, 'español', 15, 15);

-- probar update

SELECT * FROM articulos_contiene;
INSERT INTO articulos_contiene (id_articulo, idioma, cod_palabra, nro_secction)
VALUES (1, 'español', 16, 16);
UPDATE articulos_contiene SET id_articulo = 2 WHERE id_articulo = 1 AND idioma = 'español' AND cod_palabra = 16 AND nro_secction = 16;

SELECT * FROM articulos_contiene WHERE id_articulo = 2;

-- insertar 16 palabras claves para el articulo 3
DELETE FROM articulos_contiene WHERE id_articulo = 3;
INSERT INTO articulos_contiene (id_articulo, idioma, cod_palabra, nro_secction)
    VALUES (3, 'español', 1, 1), (3, 'español', 2, 2), (3, 'español', 3, 3), (3, 'español', 4, 4),
           (3, 'español', 5, 5), (3, 'español', 6, 6), (3, 'español', 7, 7), (3, 'español', 8, 8),
           (3, 'español', 9, 9), (3, 'español', 10, 10), (3, 'español', 11, 11), (3, 'español', 12, 12),
           (3, 'español', 13, 13), (3, 'español', 14, 14), (3, 'español', 15, 15), (3, 'español', 16, 16);

SELECT * FROM articulos_contiene WHERE id_articulo = 3;

-- error de cantidad de palabras claves [ok]

-- e) Sólo se pueden publicar artículos argentinos que contengan hasta 10 palabras claves.

-- CREATE ASSERTION ck_cant_palabras_claves_argentina
--     CHECK (
--         NOT EXISTS (SELECT id_articulo, idioma, count(*) as cant_palabras_claves
--                     FROM articulos_contiene
--                     INNER JOIN articulos_articulo ON articulos_contiene.id_articulo = articulos_articulo.id_articulo
--                     WHERE articulos_articulo.nacionalidad = 'Argentina'
--                     GROUP BY id_articulo, idioma
--                     HAVING count(*) > 10)
--         );
--
-- reimplementacion e) con triggers

CREATE OR REPLACE FUNCTION check_cant_palabras_claves_argentina()
    RETURNS TRIGGER AS
$$
    DECLARE cant_palabras_claves INTEGER;
    BEGIN
        SELECT count(*) INTO cant_palabras_claves
        FROM articulos_contiene
        INNER JOIN articulos_articulo ON articulos_contiene.id_articulo = articulos_articulo.id_articulo
        WHERE articulos_articulo.nacionalidad = 'Argentina' AND articulos_contiene.id_articulo = NEW.id_articulo;

        IF cant_palabras_claves >= 10 THEN
            RAISE EXCEPTION 'El articulo no puede tener mas de 10 palabras claves';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_cant_palabras_claves_argentina_tg_articulo
    BEFORE UPDATE OF nacionalidad ON articulos_articulo
    FOR EACH ROW
    WHEN ( NEW.nacionalidad = 'Argentina' AND NEW.nacionalidad <> OLD.nacionalidad)
    EXECUTE PROCEDURE check_cant_palabras_claves_argentina();

CREATE OR REPLACE TRIGGER check_cant_palabras_claves_argentina_tg_contiene
    BEFORE INSERT OR UPDATE OF id_articulo ON articulos_contiene
    FOR EACH ROW
    EXECUTE PROCEDURE check_cant_palabras_claves_argentina();