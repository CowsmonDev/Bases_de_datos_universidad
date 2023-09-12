SELECT * FROM tarea
WHERE nombre_tarea LIKE 'O%' OR nombre_tarea LIKE 'A%' OR nombre_tarea LIKE 'C%'
ORDER BY id_tarea
LIMIT 5
OFFSET 10;