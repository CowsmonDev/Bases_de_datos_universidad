-- Tomando el esquema de Voluntarios, resuelva las siguientes consultas en SQL utilizando operadores (o
-- simulando la operación) de Conjuntos. Discuta qué sucede si se incluye el operador ALL.



-- 1)
-- Indique cuáles instituciones tienen solo un voluntario trabajando y ninguna tarea desarrollada
-- -históricamente- hasta el momento.

set SEARCH_PATH = "unc_esq_voluntario";

SELECT v.id_institucion
FROM voluntario v
GROUP BY v.id_institucion
HAVING COUNT(v.id_institucion) = 1
INTERSECT
(SELECT i.id_institucion
FROM institucion i
EXCEPT
SELECT h.id_institucion
FROM historico h);

-- 2)
-- Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ o
-- que son coordinadores, y que además cumplen con el rol de director de alguna institución. Ordene el
-- resultado alfabéticamente.

set SEARCH_PATH = "unc_esq_voluntario";

SELECT nro_voluntario, nombre, apellido FROM ((SELECT v.nro_voluntario, v.nombre, v.apellido
 FROM voluntario v
 WHERE v.id_institucion IN (SELECT i.id_institucion
                            FROM institucion i
                            WHERE i.id_direccion IN (SELECT d.id_direccion
                                                     FROM direccion d
                                                     WHERE d.id_pais IN (SELECT p.id_pais
                                                                         FROM pais p
                                                                         WHERE p.id_continente IN
                                                                               (SELECT c.id_continente
                                                                                FROM continente c
                                                                                WHERE c.nombre_continente = 'Europeo'))))

 UNION

 SELECT v.nro_voluntario, v.nombre, v.apellido
 FROM voluntario v
 WHERE v.nro_voluntario IN (SELECT id_coordinador
                            FROM voluntario)
 )
INTERSECT
SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
WHERE v.nro_voluntario IN (SELECT id_director
                            FROM institucion)) as nvnanvnanvna ORDER BY nombre, apellido;


SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
JOIN institucion i USING (id_institucion)
JOIN direccion d USING (id_direccion)
JOIN pais p USING (id_pais)
JOIN continente c USING (id_continente)
WHERE (c.nombre_continente = 'Europeo' OR v.nro_voluntario IN (SELECT id_coordinador FROM voluntario))
      AND v.nro_voluntario IN (SELECT id_director FROM institucion)
ORDER BY v.nombre, v.apellido;
