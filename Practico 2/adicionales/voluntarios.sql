SET SEARCH_PATH = "unc_esq_voluntario";

-- enunciado 1: Liste los códigos de las distintas tareas que están realizando actualmente los voluntarios.
SELECT DISTINCT id_tarea FROM voluntario;

-- enunciado 2: Realice un listado donde, por cada voluntario, se indique las distintas instituciones y tareas que ha desarrollado (considere los datos históricos).
SELECT DISTINCT nro_voluntario, id_institucion, id_tarea
FROM historico
ORDER BY nro_voluntario;