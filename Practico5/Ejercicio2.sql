set search_path = "unc_250359";
--1) Cree una vista EMPLEADO_DIST_20 que liste el id_empleado, nombre, apellido, sueldo y fecha_nacimiento de los empleados que corresponden al distribuidor con identificador 20.

CREATE VIEW unc_250359.EMPLEADO_DIST_20 AS
    SELECT id_empleado, nombre, apellido, sueldo, fecha_nacimiento FROM peliculas_empleado WHERE id_distribuidor = 20;

--2) Sobre la vista anterior defina otra vista EMPLEADO_DIST_2000 con el id, nombre, apellido y sueldo de los empleados que cobran más de 2000.

CREATE VIEW unc_250359.EMPLEADO_DIST_2000 AS
    SELECT id_empleado, nombre, apellido, sueldo FROM EMPLEADO_DIST_20 WHERE sueldo > 2000;

--3) Sobre la vista EMPLEADO_DIST_20 cree la vista EMPLEADO_DIST_20_70 con aquellos empleados que han nacido en la década del 70 (entre los años 1970 y 1979).

CREATE VIEW unc_250359.EMPLEADO_DIST_20_70 AS
    SELECT * FROM EMPLEADO_DIST_20 WHERE fecha_nacimiento BETWEEN  to_date('1970-01-01', 'YYYY-MM-DD') AND to_date('1979-12-31', 'YYYY-MM-DD');

--4) Cree una vista PELICULAS_ENTREGADAS que contenga el código de cada película y la cantidad de unidades entregadas.
--5) Cree una vista DISTRIB_NAC con los el id de las distribuidoras nacionales, nro_incripcion y encargado, con distribuidor mayorista del país AR
--6) Usando la vista anterior, cree la vista DISTRIB_NAC_MAS2EMP con los datos completos de las distribuidoras nacionales cuyos departamentos tengan más de 2 empleados.
