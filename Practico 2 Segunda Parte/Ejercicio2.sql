SET SEARCH_PATH = "unc_esq_peliculas";

-- 9)
-- Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de
-- su jefe, en caso de tenerlo.

SELECT e.id_empleado, e.nombre, e.apellido, j.id_empleado as "id jefe", j.nombre "nombre jefe", j.apellido "apellido jefe"
FROM empleado e
LEFT JOIN empleado j ON e.id_jefe = j.id_empleado;


-- 10)
-- Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde
-- se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids.


SELECT e.id_empleado, e.nombre, e.apellido
FROM empleado e
JOIN departamento d ON e.id_empleado = d.jefe_departamento
JOIN ciudad c ON d.id_ciudad = c.id_ciudad
WHERE nombre_ciudad = 'Rawalpindi';

-- 11)
-- Liste los ids y números de inscripción de los distribuidores nacionales que hayan entregado películas
-- en idioma Español luego del año 2010.

SELECT d.id_distribuidor, n.nro_inscripcion
FROM distribuidor d
JOIN nacional n USING (id_distribuidor)
WHERE n.id_distribuidor IN (
    SELECT e.id_distribuidor
    FROM renglon_entrega
    JOIN pelicula USING (codigo_pelicula)
    JOIN entrega e USING (nro_entrega)
    WHERE idioma = 'Español' AND extract(year from e.fecha_entrega) > 2010
)
ORDER BY d.id_distribuidor;

-- 12)
-- Liste las películas que nunca han sido entregadas por un distribuidor nacional.

SELECT p.codigo_pelicula, p.titulo
FROM pelicula p
WHERE p.codigo_pelicula NOT IN (
    SELECT p.codigo_pelicula
    FROM pelicula p
    JOIN renglon_entrega re USING (codigo_pelicula)
    JOIN entrega e USING (nro_entrega)
    JOIN distribuidor d USING (id_distribuidor)
    JOIN nacional n USING (id_distribuidor)
);

-- 13)
-- Liste el apellido y nombre de los empleados que trabajan en departamentos residentes en el país
-- Argentina y donde el jefe de departamento posee más del 40% de comisión.

SELECT d.id_departamento, id_empleado, nombre_pais, porc_comision FROM departamento d
INNER JOIN empleado e ON e.id_empleado = d.jefe_departamento
INNER JOIN ciudad c USING(id_ciudad)
INNER JOIN pais p USING(id_pais)
WHERE nombre_pais = 'ARGENTINA' AND e.porc_comision > 40;

-- 14)
-- Indique los departamentos (nombre e identificador completo) que tienen más de 3 empleados con
-- tareas con sueldo mínimo menor a 6000. Muestre el resultado ordenado por distribuidor.


SELECT d.nombre, d.id_distribuidor, d.id_departamento
FROM departamento d
WHERE (d.id_departamento, d.id_distribuidor) IN (
    SELECT e.id_departamento, e.id_distribuidor
    FROM empleado e
    JOIN tarea t USING (id_tarea)
    WHERE t.sueldo_minimo < 6000
    GROUP BY id_departamento, e.id_distribuidor
    HAVING COUNT(*) > 3
);

-- 15)
-- Liste los datos de los departamentos en los que trabajan menos del 10 % de los empleados que hay
-- registrados.

SELECT d.id_departamento, d.id_distribuidor, d.nombre
FROM departamento d
WHERE (d.id_departamento, d.id_distribuidor) IN (
    SELECT e.id_departamento, e.id_distribuidor
    FROM empleado e
    GROUP BY e.id_departamento, e.id_distribuidor
    HAVING COUNT(*) < (SELECT COUNT(*) FROM empleado) * 0.1
);
