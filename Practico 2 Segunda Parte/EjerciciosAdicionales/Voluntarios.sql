
SET SEARCH_PATH = "unc_esq_voluntario";

-- 1)
-- Realice un resumen por país, indicando el nombre del país y la cantidad de voluntarios mayores de
-- edad. Tenga en cuenta sólo aquellos voluntarios que pertenezcan a instituciones con más de 4
-- voluntarios.


SELECT p.nombre_pais, SUM(cantidad_voluntarios_mayores) as cantidad_voluntarios
FROM institucion i
JOIN (SELECT id_institucion, COUNT(*) as cantidad_voluntarios_mayores
    FROM voluntario
    WHERE extract(year from age(fecha_nacimiento)) > 18 AND id_institucion IN (
                                                            SELECT id_institucion
                                                            FROM voluntario
                                                            GROUP BY id_institucion
                                                            HAVING COUNT(*) > 4
                                                        )
    GROUP BY id_institucion) as vm ON vm.id_institucion = i.id_institucion

JOIN direccion d USING (id_direccion)
JOIN pais p USING (id_pais)
GROUP BY p.nombre_pais

-- 2)
-- Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ y
-- que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente
-- por apellido y nombre.


SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
JOIN (SELECT DISTINCT id_director
        FROM institucion i
        WHERE id_director IS NOT NULL) as dv ON dv.id_director = v.nro_voluntario
JOIN (
     SELECT i.id_institucion
    FROM institucion i
    JOIN direccion d USING (id_direccion)
    JOIN pais p USING (id_pais)
    JOIN continente c USING (id_continente)
    WHERE c.nombre_continente = 'Europeo' AND i.id_director IS NOT NULL
) as i USING(id_institucion);


SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
WHERE v.nro_voluntario IN (SELECT DISTINCT id_director
        FROM institucion i
        WHERE id_director IS NOT NULL)
AND id_institucion IN(
        SELECT i.id_institucion
        FROM institucion i
        JOIN direccion d USING (id_direccion)
        JOIN pais p USING (id_pais)
        JOIN continente c USING (id_continente)
        WHERE c.nombre_continente = 'Europeo' AND i.id_director IS NOT NULL
);

-- 3)
-- Indique el id y el nombre de las instituciones que tengan más de 4 voluntarios con tareas de no más de
-- 3500 horas estimadas, o que las horas aportadas no superen las 4000.

SELECT i.id_institucion, i.nombre_institucion
FROM institucion i
WHERE i.id_institucion IN(
        SELECT v.id_institucion
        FROM voluntario v
        JOIN tarea t USING (id_tarea)
        WHERE t.max_horas <= 3500 AND v.horas_aportadas <= 4000
        GROUP BY v.id_institucion
        HAVING COUNT(*) > 4
)

