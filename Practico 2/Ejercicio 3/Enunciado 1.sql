SELECT id_empleado ,apellido, nombre FROM empleado
WHERE porc_comision IS NULL OR porc_comision = 0
ORDER BY apellido