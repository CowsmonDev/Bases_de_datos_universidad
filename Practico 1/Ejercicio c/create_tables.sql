-- DROP TABLE Grabacion_Comercial_tp_1_table_c;
-- DROP TABLE Grabacion_No_Propia_tp_1_table_c;
-- DROP TABLE Equipo_tp_1_table_c;
-- DROP TABLE Grabacion_tp_1_table_c;

CREATE TABLE Grabacion_tp_1_table_c
(
    nro_grabacion INT NOT NULL,
    casa_discografica VARCHAR(50) NOT NULL,
    fecha_grabacion DATE NOT NULL,
    tipo char(1) NOT NULL,
    CONSTRAINT Grabacion_pk PRIMARY KEY (nro_grabacion)
);

CREATE TABLE Equipo_tp_1_table_c
(
    nro_equipo INT NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT Equipo_pk PRIMARY KEY (nro_equipo)
);

CREATE TABLE Grabacion_No_Propia_tp_1_table_c
(
    nro_grabacion INT NOT NULL,
    duracion INT NOT NULL,
    CONSTRAINT Grabacion_No_Propia_pk PRIMARY KEY (nro_grabacion)
);

CREATE TABLE Grabacion_Comercial_tp_1_table_c(
    nro_grabacion INT NOT NULL,
    nro_equipo INT NOT NULL,
    CONSTRAINT Grabacion_Comercial_pk PRIMARY KEY (nro_grabacion)
);

-- FOREIGN KEYS
ALTER TABLE Grabacion_No_Propia_tp_1_table_c ADD CONSTRAINT Grabacion_No_Propia_fk
    FOREIGN KEY (nro_grabacion)
    REFERENCES Grabacion_tp_1_table_c (nro_grabacion);

ALTER TABLE Grabacion_Comercial_tp_1_table_c ADD CONSTRAINT Grabacion_Comercial_fk
    FOREIGN KEY (nro_grabacion)
    REFERENCES Grabacion_tp_1_table_c (nro_grabacion);

ALTER TABLE Grabacion_Comercial_tp_1_table_c ADD CONSTRAINT Grabacion_Comercial_fk2
    FOREIGN KEY (nro_equipo)
    REFERENCES Equipo_tp_1_table_c (nro_equipo);