set SEARCH_PATH = "unc_esq_voluntario";

-- enunciado 1
SELECT MIN(horas_aportadas), MAX(horas_aportadas), AVG(horas_aportadas)
FROM voluntario
WHERE age(fecha_nacimiento) > '25 years';

-- enunciado 2
SELECT id_institucion, COUNT(id_institucion)
FROM voluntario
GROUP BY id_institucion;

-- enunciado 3: Muestre la fecha de nacimiento del voluntario más joven y del más viejo
SELECT MIN(fecha_nacimiento) as "MasAntiguo", MAX(fecha_nacimiento) as "MasJoven"
FROM voluntario;

-- enunciado 4: Considerando los datos históricos de cada voluntario, indique la cantidad de tareas distintas que cada uno ha realizado.
SELECT nro_voluntario , COUNT(DISTINCT id_tarea), COUNT (id_tarea)
FROM historico
GROUP BY nro_voluntario;

-- enunciado 5: Se quiere conocer los coordinadores que tienen a su cargo menos de 3 voluntarios dentro de cada institución
SELECT id_institucion, id_coordinador, COUNT(nro_voluntario)
FROM voluntario
WHERE id_coordinador IS NOT NULL AND id_institucion IS NOT NULL
GROUP BY id_institucion, id_coordinador
HAVING COUNT(nro_voluntario) < 3;