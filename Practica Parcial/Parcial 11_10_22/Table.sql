set search_path = "unc_250359";

CREATE TABLE P1_PLAN(
    cod_plan int,
    nombre varchar(50),
    anio_inicio int,
    importe int,
    PRIMARY KEY(cod_plan)
);

CREATE TABLE P1_PLAN_PART(
    cod_plan int,
    caracteristica varchar(80),
    PRIMARY KEY(cod_plan)
);

CREATE TABLE P1_PLAN_EMPR(
    cod_plan int,
    condicion varchar(80),
    descuento decimal(5,2),
    PRIMARY KEY(cod_plan)
);

CREATE TABLE P1_ASIGNACION(
    nroUsuario int,
    zona char(2),
    cod_plan int,
    fecha_desde date,
    fecha_hasta date NULL,
    num_dispositivos int,
    PRIMARY KEY(nroUsuario, zona, cod_plan)
);

CREATE TABLE P1_USUARIO(
    nroUsuario int,
    zona char(2),
    apell_nombre varchar(50),
    ciudad varchar(20),
    fecha_nacim date,
    PRIMARY KEY(nroUsuario, zona)
);

CREATE TABLE P1_ZONA(
    zona char(2),
    nombre varchar(30),
    PRIMARY KEY(zona)
);

ALTER TABLE P1_PLAN_PART
    ADD CONSTRAINT fk_cod_plan_part FOREIGN KEY (cod_plan) REFERENCES P1_PLAN(cod_plan);

ALTER TABLE P1_PLAN_EMPR
    ADD CONSTRAINT fk_cod_plan_empr FOREIGN KEY (cod_plan) REFERENCES P1_PLAN(cod_plan);

ALTER TABLE P1_ASIGNACION
    ADD CONSTRAINT fk_cod_plan_asig FOREIGN KEY (cod_plan) REFERENCES P1_PLAN(cod_plan),
    ADD CONSTRAINT fk_nroUsuario_asig FOREIGN KEY (nroUsuario, zona) REFERENCES P1_USUARIO(nroUsuario, zona);

ALTER TABLE P1_USUARIO
    ADD CONSTRAINT fk_zona FOREIGN KEY (zona) REFERENCES P1_ZONA(zona);