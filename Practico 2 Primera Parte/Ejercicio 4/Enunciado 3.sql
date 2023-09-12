
SELECT nombre,
       apellido,
       extract(year from age(fecha_nacimiento)) as edad
FROM voluntario
WHERE
    extract(day from fecha_nacimiento) = extract(day from now())
    AND extract(month from fecha_nacimiento) = extract(month from now())
