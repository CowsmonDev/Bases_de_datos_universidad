set search_path = "unc_250359";

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-10-06 21:42:41.102

-- tables
-- Table: ARTICULO
CREATE TABLE ARTICULO (
                          id_articulo varchar(10)  NOT NULL,
                          descripcion varchar(30)  NOT NULL,
                          precio decimal(8,2)  NOT NULL,
                          peso decimal(5,2)  NULL,
                          ciudad varchar(30)  NOT NULL,
                          CONSTRAINT ARTICULO_pk PRIMARY KEY (id_articulo)
);

-- Table: ENVIO
CREATE TABLE ENVIO (
                       id_proveedor varchar(10)  NOT NULL,
                       id_articulo varchar(10)  NOT NULL,
                       cantidad int  NOT NULL,
                       CONSTRAINT ENVIO_pk PRIMARY KEY (id_proveedor,id_articulo)
);

-- Table: PROVEEDOR
CREATE TABLE PROVEEDOR (
                           id_proveedor varchar(10)  NOT NULL,
                           nombre varchar(30)  NOT NULL,
                           rubro varchar(15)  NOT NULL,
                           ciudad varchar(30)  NOT NULL,
                           CONSTRAINT PROVEEDOR_pk PRIMARY KEY (id_proveedor)
);

-- foreign keys
-- Reference: ENVIO_ARTICULO (table: ENVIO)
ALTER TABLE ENVIO ADD CONSTRAINT ENVIO_ARTICULO
    FOREIGN KEY (id_articulo)
        REFERENCES ARTICULO (id_articulo)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: ENVIO_PROVEEDOR (table: ENVIO)
ALTER TABLE ENVIO ADD CONSTRAINT ENVIO_PROVEEDOR
    FOREIGN KEY (id_proveedor)
        REFERENCES PROVEEDOR (id_proveedor)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- End of file.

-- insertar 5 elementos de prueba en cada una de la tabla de proveedor y articulo, con datos variados, que la insercion sea masiva

DELETE FROM PROVEEDOR WHERE TRUE;
DELETE FROM ARTICULO WHERE TRUE;
DELETE FROM ENVIO WHERE TRUE;

INSERT INTO PROVEEDOR VALUES ('P1', 'Proveedor 1', 'Rubro 1', 'Tandil'), ('P2', 'Proveedor 2', 'Rubro 2', 'Tandil'), ('P3', 'Proveedor 3', 'Rubro 3', 'Tandil'), ('P4', 'Proveedor 4', 'Rubro 4', 'Tandil'), ('P5', 'Proveedor 5', 'Rubro 5', 'Tandil');
INSERT INTO ARTICULO VALUES ('A1', 'Articulo 1', 100, 10, 'Tandil'), ('A2', 'Articulo 2', 200, 20, 'Tandil'), ('A3', 'Articulo 3', 300, 30, 'Tandil'), ('A4', 'Articulo 4', 400, 40, 'Tandil'), ('A5', 'Articulo 5', 500, 50, 'Tandil');

-- insertar el producto cruzado en envio de los 5 elementos de prueba de proveedor y articulo

INSERT INTO ENVIO VALUES ('P1', 'A1', 650), ('P1', 'A2', 200), ('P1', 'A3', 300), ('P1', 'A4', 400), ('P1', 'A5', 500), ('P2', 'A1', 100), ('P2', 'A2', 200), ('P2', 'A3', 300), ('P2', 'A4', 400), ('P2', 'A5', 500), ('P3', 'A1', 100), ('P3', 'A2', 200), ('P3', 'A3', 300), ('P3', 'A4', 700), ('P3', 'A5', 500), ('P4', 'A1', 100), ('P4', 'A2', 200), ('P4', 'A3', 300), ('P4', 'A4', 400), ('P4', 'A5', 500), ('P5', 'A1', 100), ('P5', 'A2', 200), ('P5', 'A3', 300), ('P5', 'A4', 400), ('P5', 'A5', 500);


SELECT * FROM PROVEEDOR;
SELECT * FROM ARTICULO;
SELECT * FROM ENVIO;

-- Ejercicio a

-- a.1) ENVIOS500 con los envíos de 500 o más unidades (a partir de ENVIO)
CREATE VIEW ENVIOS500 AS
    SELECT * FROM ENVIO WHERE cantidad >= 500;

SELECT * FROM ENVIOS500;

-- a.2) ENVIOS500-M con los envíos de entre 500 y 999 unidades (a partir de ENVIOS500)

CREATE VIEW ENVIOS500_M AS
    SELECT * FROM ENVIOS500 WHERE cantidad < 1000;

SELECT * FROM ENVIOS500_M;

-- a.3) RUBROS_PROV con los diferentes rubros que poseen los proveedores ubicados en Tandil

CREATE VIEW RUBROS_PROV AS
    SELECT DISTINCT rubro FROM PROVEEDOR WHERE ciudad = 'Tandil';

SELECT * FROM RUBROS_PROV;

-- a.4) ENVIOS_PROV con los diferentes id y nombre de proveedor y la cantidad total de unidades enviadas

CREATE VIEW ENVIOS_PROV AS
    SELECT p.id_proveedor, nombre, SUM(cantidad) AS cantidad_total
        FROM PROVEEDOR p
        INNER JOIN ENVIO E on p.id_proveedor = E.id_proveedor
        GROUP BY p.id_proveedor, nombre;