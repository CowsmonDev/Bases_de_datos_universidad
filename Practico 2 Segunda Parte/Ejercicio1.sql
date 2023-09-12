SET SEARCH_PATH = "unc_esq_voluntario";

-- 1)
-- Haga un resumen de cuantas veces ha cambiado de tareas cada voluntario. Indique el número,
-- nombre y apellido del voluntario

SELECT v.nro_voluntario, v.nombre, v.apellido, COUNT(h.nro_voluntario)
FROM voluntario v
INNER JOIN historico h on v.nro_voluntario = h.nro_voluntario
GROUP BY v.nro_voluntario, v.nombre, v.apellido;

-- 2)
-- Liste los datos de contacto (nombre, apellido, e-mail y teléfono) de los voluntarios que hayan
-- desarrollado tareas con diferencia max_horas-min_horas de hasta 5000 horas y que las hayan
-- finalizado antes del 01/01/2000.

SELECT v.nro_voluntario, v.nombre, v.apellido, v.e_mail, v.telefono
FROM voluntario v
JOIN historico h USING (nro_voluntario)
JOIN tarea t on h.id_tarea = t.id_tarea
WHERE (t.max_horas - t.min_horas) <= 5000 AND h.fecha_fin < to_date('01/01/2000', 'dd/mm/yyyy')
ORDER BY v.nro_voluntario;

-- 3)
-- Indique nombre, id y dirección completa de las instituciones que no poseen voluntarios con aporte de
-- horas mayor o igual que el máximo de horas de la tarea que realiza.

SELECT i.id_institucion, i.nombre_institucion, d.calle, codigo_postal, ciudad, provincia , p.nombre_pais, c.nombre_continente
FROM institucion i
JOIN direccion d USING (id_direccion)
JOIN pais p USING (id_pais)
JOIN continente c USING (id_continente)
WHERE NOT EXISTS(
    SELECT 1
    FROM voluntario v
    JOIN tarea t USING (id_tarea)
    WHERE v.horas_aportadas >= t.max_horas AND v.id_institucion = i.id_institucion
)
ORDER BY i.id_institucion;

-- 4)
-- Liste en orden alfabético los nombres de los países que nunca han tenido acción de voluntarios
-- (considerando sólo información histórica, no tener en cuenta los voluntarios actuales)

SELECT p.nombre_pais
FROM pais p
WHERE p.id_pais NOT IN (
    SELECT d.id_pais
    FROM direccion d
    JOIN institucion i USING (id_direccion)
    JOIN historico h USING (id_institucion)
)
ORDER BY p.nombre_pais;

-- 5)
-- Indique los datos de las tareas que se han desarrollado históricamente y que no se están desarrollando
-- actualmente.

-- si esta en historico, no se esta realizando actualmente

SELECT t.id_tarea, t.nombre_tarea, t.min_horas, t.max_horas, h.fecha_inicio, nro_voluntario, fecha_fin, id_institucion
FROM tarea t
JOIN historico h USING(id_tarea);

-- 6)
--Liste el id, nombre y máxima cantidad de horas de las tareas que se están ejecutando solo una vez y
--que actualmente la están realizando voluntarios de la ciudad ‘Munich’. Ordene por id de tarea.

SELECT t.id_tarea, t.nombre_tarea, t.max_horas
FROM tarea t
JOIN voluntario v on t.id_tarea = v.id_tarea
JOIN institucion i ON v.id_institucion = i.id_institucion
JOIN direccion d on i.id_direccion = d.id_direccion
WHERE t.id_tarea NOT IN (
    SELECT h.id_tarea
    FROM historico h
) AND d.ciudad = 'Munich'
GROUP BY t.id_tarea, t.nombre_tarea, t.max_horas
HAVING COUNT(*) = 1
ORDER BY t.id_tarea;

-- 7)
-- Indique los datos de las instituciones que poseen director, donde históricamente se hayan desarrollado
-- tareas que actualmente las estén ejecutando voluntarios de otras instituciones.

SELECT i.id_institucion, i.nombre_institucion, id_tarea
FROM institucion i
JOIN historico h on i.id_institucion = h.id_institucion
WHERE id_director IS NOT NULL AND EXISTS (
    SELECT 1
    FROM voluntario v
    WHERE v.id_tarea = h.id_tarea AND v.id_institucion != h.id_institucion
);

-- 8)
-- Liste los datos completos de todas las instituciones junto con el apellido y nombre de su director, si
-- poseen.

SELECT i.id_institucion, i.nombre_institucion, i.id_director, v.nombre, v.apellido
FROM institucion i
LEFT JOIN voluntario v on i.id_director = v.nro_voluntario;