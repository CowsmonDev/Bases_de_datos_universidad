-- DROP TABLE Curso_tp_1_table_b
-- DROP TABLE Inscripto_tp_1_table_b
-- DROP TABLE Alumno_tp_1_table_b

-- tablas
CREATE TABLE Curso_tp_1_table_b (
    cod char(4) NOT NULL,
    descripcion varchar(40) NOT NULL,
    tipo char(1) NOT NULL,
    cod_inscripto char(4),
    LU_inscripto decimal(5,0),
    CONSTRAINT Curso_pk PRIMARY KEY (cod)
);

CREATE TABLE Inscripto_tp_1_table_b (
    cod_inscripto char(4) NOT NULL,
    LU_inscripto decimal(5,0) NOT NULL,
    CONSTRAINT Inscripto_pk PRIMARY KEY (cod_inscripto, LU_inscripto)
);

CREATE TABLE Alumno_tp_1_table_b (
    LU decimal(5,0) NOT NULL,
    nombre varchar(40) NOT NULL,
    provincia varchar(30) NOT NULL,
    CONSTRAINT Alumno_pk PRIMARY KEY (LU)
);

-- claves foraneas
ALTER TABLE Curso_tp_1_table_b ADD CONSTRAINT Curso_fk
    FOREIGN KEY (cod_inscripto, LU_inscripto)
        REFERENCES Inscripto_tp_1_table_b (cod_inscripto, LU_inscripto);

ALTER TABLE Inscripto_tp_1_table_b ADD CONSTRAINT Inscripto_fk
    FOREIGN KEY (LU_inscripto)
        REFERENCES Alumno_tp_1_table_b (LU);

ALTER TABLE Inscripto_tp_1_table_b ADD CONSTRAINT Inscripto_fk_2
    FOREIGN KEY (cod_inscripto)
        REFERENCES Curso_tp_1_table_b (cod);