-- DROP TABLE Contiene_tp_1_table_a;
-- DROP TABLE Articulo_tp_1_table_a;
-- DROP TABLE Palabra_tp_1_table_a;

-- tabla articulo

CREATE TABLE Articulo_tp_1_table_a(
    id_articulo decimal(4,0) NOT NULL,
    titulo varchar(120) NOT NULL,
    autor varchar(30) NOT NULL,
    fecha_pub date NOT NULL,
    CONSTRAINT Articulo_pk PRIMARY KEY (id_articulo)
);

-- tabla Palabra
CREATE TABLE Palabra_tp_1_table_a(
    cod_p decimal(4,0) NOT NULL,
    idioma char(2) NOT NULL,
    descripcion varchar(25) NOT NULL,
    CONSTRAINT Palabra_pk PRIMARY KEY (cod_p, idioma)
);

-- tabla Contiene relacion entre Articulo y Palabra
CREATE TABLE Contiene_tp_1_table_a(
    id_articulo decimal(4,0) NOT NULL,
    cod_p decimal(4,0) NOT NULL,
    idioma char(2) NOT NULL,
    CONSTRAINT Contiene_pk PRIMARY KEY (id_articulo, cod_p, idioma)
);

-- foreign keys
ALTER TABLE Contiene_tp_1_table_a ADD CONSTRAINT contiene_articulo
    FOREIGN KEY (id_articulo)
    REFERENCES Articulo_tp_1_table_a (id_articulo)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

ALTER TABLE Contiene_tp_1_table_a ADD CONSTRAINT contiene_palabra
    FOREIGN KEY (cod_p, idioma)
    REFERENCES Palabra_tp_1_table_a (cod_p, idioma)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;