set search_path = "unc_250359";

-- vista 1
-- voluntario es la tabla en esta vista que es automaticamente actualizable
CREATE OR REPLACE VIEW UsuarioTareaRealizada AS
SELECT nro_voluntario, nombre, apellido, horas_aportadas, t.*
FROM voluntario v
         INNER JOIN tarea t USING (id_tarea);

-- vista2: datos de las instituciones ubicadas en el país US junto con la cantidad de tareas que se han realizado en ellas
DROP VIEW IF EXISTS InstitucionesUS;
CREATE OR REPLACE VIEW InstitucionesUS AS
(
select institucion.*, cantidad_tareas
from institucion
         inner join direccion d using (id_direccion)
         inner join pais p using (id_pais)
         inner join (select id_institucion, count(*) as cantidad_tareas
                     from historico
                     group by id_institucion) as tareas_realizadas
                    using (id_institucion) -- cantidad de tareas realizadas en esa instituciones
where p.nombre_pais = 'Estados Unidos'
    );

-- vista3: identificador y nombre de todas las instituciones existentes, con la cantidad de voluntarios que están trabajando en cada una

DROP VIEW IF EXISTS InstitucionesVoluntarios;
CREATE OR REPLACE VIEW InstitucionesVoluntarios AS
(
select i.id_institucion, i.nombre_institucion, cantidad_voluntarios
from institucion i
         inner join (select id_institucion, count(*) as cantidad_voluntarios
                     from voluntario
                     group by id_institucion) as voluntarios_por_institucion using (id_institucion)
    );