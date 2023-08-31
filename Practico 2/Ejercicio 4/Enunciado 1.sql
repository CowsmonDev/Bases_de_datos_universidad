SELECT
    apellido||','||nombre as "apellido y nombre",
    to_char(fecha_nacimiento, 'YYYY-MM-DD') as "fecha de nacimiento"
FROM voluntario
ORDER BY extract(year from fecha_nacimiento)
