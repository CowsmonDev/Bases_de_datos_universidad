SELECT * FROM voluntario
WHERE extract(year from fecha_nacimiento) > 1998 AND horas_aportadas > 5000
ORDER BY nro_voluntario