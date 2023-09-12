SET SEARCH_PATH = "unc_esq_peliculas";

-- 9)
-- Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de
-- su jefe, en caso de tenerlo.

SELECT e.id_empleado, e.nombre, e.apellido, j.id_empleado as "id jefe", j.nombre "nombre jefe", j.apellido "apellido jefe"
FROM empleado e
LEFT JOIN empleado j ON e.id_jefe = j.id_empleado

-- 10)
-- Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde
-- se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids.
