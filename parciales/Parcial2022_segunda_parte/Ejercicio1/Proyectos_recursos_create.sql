set search_path = "unc_250359";
-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-28 01:19:24.761

-- tables
-- Table: AREA
CREATE TABLE PARCIAL2022_AREA
(
    cod_area       char(5)     NOT NULL,
    nom_area       varchar(30) NOT NULL,
    ubicacion      varchar(50) NOT NULL,
    cant_empleados int         NOT NULL,
    responsable    varchar(50) NOT NULL,
    CONSTRAINT AREA_pk PRIMARY KEY (cod_area)
);

-- Table: ETAPA
CREATE TABLE PARCIAL2022_ETAPA
(
    id_proy      int          NOT NULL,
    cod_area     char(5)      NOT NULL,
    id_etapa     int          NOT NULL,
    descripcion  varchar(200) NOT NULL,
    fecha_inicio date         NOT NULL,
    fecha_fin    date         NULL,
    CONSTRAINT PK_ALQUILER PRIMARY KEY (id_etapa, id_proy, cod_area)
);

-- Table: PROYECTO
CREATE TABLE PARCIAL2022_PROYECTO
(
    id_proy      int            NOT NULL,
    cod_area     char(5)        NOT NULL,
    nombre       varchar(50)    NOT NULL,
    presupuesto  decimal(10, 2) NOT NULL,
    fecha_inicio date           NOT NULL,
    fecha_fin    date           NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (id_proy, cod_area)
);

-- Table: RECURSO
CREATE TABLE PARCIAL2022_RECURSO
(
    id_recurso    varchar(10) NOT NULL,
    nombre        varchar(40) NOT NULL,
    desarrollador varchar(50) NULL,
    recomendacion text        NOT NULL,
    CONSTRAINT PK_ALOJAMIENTO PRIMARY KEY (id_recurso)
);

-- Table: USO_RECURSO
CREATE TABLE PARCIAL2022_USO_RECURSO
(
    id_etapa    int          NOT NULL,
    id_proy     int          NOT NULL,
    cod_area    char(5)      NOT NULL,
    id_recurso  varchar(10)  NOT NULL,
    observacion varchar(100) NULL,
    CONSTRAINT PK_ALQUILER_ALOJ PRIMARY KEY (id_etapa, id_proy, cod_area, id_recurso)
);

-- foreign keys
-- Reference: ETAPA_PROYECTO (table: ETAPA)
ALTER TABLE PARCIAL2022_ETAPA
    ADD CONSTRAINT ETAPA_PROYECTO
        FOREIGN KEY (id_proy, cod_area)
            REFERENCES PARCIAL2022_PROYECTO (id_proy, cod_area)
            ON UPDATE CASCADE
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: PROYECTO_AREA (table: PROYECTO)
ALTER TABLE PARCIAL2022_PROYECTO
    ADD CONSTRAINT PROYECTO_AREA
        FOREIGN KEY (cod_area)
            REFERENCES PARCIAL2022_AREA (cod_area)
            ON DELETE CASCADE
            ON UPDATE CASCADE
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: USO_REC_ETAPA (table: USO_RECURSO)
ALTER TABLE PARCIAL2022_USO_RECURSO
    ADD CONSTRAINT USO_REC_ETAPA
        FOREIGN KEY (id_etapa, id_proy, cod_area)
            REFERENCES PARCIAL2022_ETAPA (id_etapa, id_proy, cod_area)
            ON UPDATE CASCADE
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: USO_REC_RECURSO (table: USO_RECURSO)
ALTER TABLE PARCIAL2022_USO_RECURSO
    ADD CONSTRAINT USO_REC_RECURSO
        FOREIGN KEY (id_recurso)
            REFERENCES PARCIAL2022_RECURSO (id_recurso)
            ON UPDATE CASCADE
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- End of file.

-- INSERTS:

INSERT INTO PARCIAL2022_AREA (cod_area, nom_area, ubicacion, cant_empleados, responsable)
VALUES ('A003', 'Derecho', 'Piso 2', 10, 'Chavez Gonzales'),
       ('A004', 'Contabilidad', 'Piso 2', 10, 'Laura Martínez'),

       ('A005', 'Soporte Técnico', 'Piso 4', 25, 'José Fernández'),
       ('A006', 'Marketing', 'Piso 3', 18, 'Sofía Rodríguez'),
       ('A007', 'Logística', 'Piso 5', 12, 'Miguel Sánchez'),
       ('A008', 'Investigación y Desarrollo', 'Piso 6', 35, 'Elena Pérez'),
       ('A009', 'Recursos Humanos', 'Piso 1', 21, 'Juan López'),
       ('A010', 'Desarrollo', 'Piso 2', 28, 'Luisa González'),
       ('A011', 'Ventas', 'Piso 3', 13, 'Carlos Rodríguez'),
       ('A012', 'Administración', 'Piso 4', 20, 'Ana Ramírez'),
       ('A013', 'Calidad', 'Piso 5', 8, 'María Soto');

INSERT INTO PARCIAL2022_PROYECTO (id_proy, cod_area, nombre, presupuesto, fecha_inicio, fecha_fin)
VALUES (3, 'A003', 'Expansión de Mercado', 90000.00, '2023-04-01', '2023-10-31'),
       (4, 'A004', 'Auditoría Anual', 15000.75, '2023-03-01', '2023-04-30'),
       (5, 'A005', 'Soporte Técnico 2023', 45000.50, '2023-05-01', '2023-12-31'),
       (6, 'A006', 'Campaña Primavera', 8000.00, '2023-05-15', '2023-06-15'),
       (7, 'A007', 'Optimización de Almacén', 20000.25, '2023-02-15', '2023-06-30'),
       (8, 'A008', 'Investigación de Producto X', 55000.00, '2023-01-15', '2023-06-30'),
       (9, 'A009', 'Contratación 2023', 30000.00, '2023-01-01', '2023-03-31'),
       (10, 'A010', 'Sistema de Control de Inventario', 70000.50, '2023-07-01', '2023-12-31'),
       (11, 'A011', 'Expansión de Ventas', 60000.00, '2023-04-01', '2023-12-31');


INSERT INTO PARCIAL2022_ETAPA (id_proy, cod_area, id_etapa, descripcion, fecha_inicio, fecha_fin)
VALUES (3, 'A003', 1, 'Planificación de ventas', '2023-04-05', NULL),
       (3, 'A003', 2, 'Ejecución de estrategia', '2023-04-15', '2023-05-20'),
       (4, 'A004', 1, 'Auditoría financiera', '2023-03-20', NULL),
       (5, 'A005', 1, 'Asistencia técnica', '2023-05-10', NULL),
       (6, 'A006', 1, 'Campaña publicitaria', '2023-06-01', '2023-06-30'),
       (7, 'A007', 1, 'Gestión de inventario', '2023-03-15', NULL),
       (8, 'A008', 1, 'Investigación de mercado', '2023-02-10', '2023-03-20'),
       (9, 'A009', 1, 'Selección de personal', '2023-01-05', NULL),
       (10, 'A010', 1, 'Diseño de software', '2023-07-01', '2023-08-15'),
       (11, 'A011', 1, 'Identificación de clientes potenciales', '2023-04-10', NULL),
        (12, 'A011', 1, 'analisis...', to_date('31/11/2022', 'DD/MM/YYYY'), NULL);

INSERT INTO PARCIAL2022_ETAPA (id_proy, cod_area, id_etapa, descripcion, fecha_inicio, fecha_fin) values
    (11, 'A011', 2, 'analisis...', '2022-11-01', NULL);

SELECT * FROM PARCIAL2022_ETAPA WHERE id_proy = 11;


INSERT INTO PARCIAL2022_RECURSO (id_recurso, nombre, desarrollador, recomendacion)
VALUES ('R004', 'Analista de Datos', 'Laura Rodríguez', 'Python y Pandas'),
       ('R005', 'Diseñador UX', 'Mario Gómez', 'Figma y Sketch'),
       ('R006', 'Programador C++', 'Javier Soto', 'Visual Studio'),
       ('R007', 'Especialista en Marketing', 'Eva Pérez', 'Google Ads'),
       ('R008', 'Desarrollador Web', 'Sara López', 'HTML, CSS, JavaScript'),
       ('R009', 'Especialista en Logística', NULL, 'SAP SCM'),
       ('R010', 'Analista de Investigación', 'Diego Martínez', 'SPSS'),
       ('R011', 'Gestor de Recursos Humanos', 'Isabel Ramírez', 'HRIS software'),
       ('R012', 'Diseñador Gráfico', 'Luis González', 'Adobe Illustrator'),
       ('R013', 'Analista Vista', 'Ana Sánchez', 'PyCharm');


INSERT INTO PARCIAL2022_USO_RECURSO (id_etapa, id_proy, cod_area, id_recurso, observacion)
VALUES (1, 3, 'A003', 'R004', 'Análisis de datos en curso'),
       (2, 3, 'A003', 'R006', 'Auditoría en progreso'),
       (1, 4, 'A004', 'R005', 'Soporte técnico a clientes'),
       (1, 5, 'A005', 'R007', 'Campaña publicitaria activa'),
       (1, 6, 'A006', 'R009', 'Optimización de inventario'),
       (1, 7, 'A007', 'R010', 'Investigación de mercado en curso'),
       (1, 8, 'A008', 'R011', 'Proceso de selección en marcha'),
       (1, 9, 'A009', 'R012', 'Diseño de software en desarrollo'),
       (1, 10, 'A010', 'R013', 'Pruebas de software en curso'),
       (1, 11, 'A011', 'R004', 'Análisis de ventas en curso');

-- insertar el recurso con id_recurso = 'R013' y con cualquier elemento de etapa INSERT INTO PARCIAL2022_USO_RECURSO (id_etapa, id_proy, cod_area, id_recurso, observacion) values (1, 11, 'A011', 'R013', 'Pruebas de software en curso');

-- insertar un recurso con id_recurso = 'R013' y con cualquier elemento de etapa y que no tenga observacion
INSERT INTO PARCIAL2022_USO_RECURSO (id_etapa, id_proy, cod_area, id_recurso, observacion) values
    (1, 11, 'A011', 'R013', NULL);

-- insertame los dos siguientes elementos juntos en la tabla USO_RECURSO
-- Etapa: (12, 'A011', 1, 'analisis...', to_date('31/11/2022', 'DD/MM/YYYY'), NULL);
-- Recurso: ('R014', 'Analista Vista', 'Ana Sánchez', 'PyCharm');
INSERT INTO PARCIAL2022_USO_RECURSO (id_etapa, id_proy, cod_area, id_recurso, observacion) values
    (1, 11, 'A011', 'R014', 'Pruebas de software en curso');

-- insertame los dos siguientes elementos juntos en la tabla USO_RECURSO
-- Etapa: (12, 'A011', 1, 'analisis...', to_date('31/11/2022', 'DD/MM/YYYY'), NULL);
-- Recurso: ('R015', 'Analista Vista', 'Ana Sánchez', 'PyCharm');
INSERT INTO PARCIAL2022_USO_RECURSO (id_etapa, id_proy, cod_area, id_recurso, observacion) values
    (1, 11, 'A011', 'R015', 'Pruebas de software en curso');
DELETE FROM PARCIAL2022_USO_RECURSO WHERE id_etapa = 1 AND id_proy = 11 AND cod_area = 'A011' AND id_recurso = 'R015';