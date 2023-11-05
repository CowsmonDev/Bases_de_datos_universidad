set search_path = "unc_250359";
-- Considere las siguientes sentencias en PostgreSQL definidas sobre el esquema dado de gestión de proyectos.
-- Determine cuál/es de ellas permite/n definir correctamente una vista con los identificadores de los proyectos
-- con al menos 2 etapas iniciadas el día de hoy y justifique abajo cada una de las opciones descartadas. (Nota:
-- tenga en cuenta que las opciones incorrectas pueden llegar a restar puntaje)

CREATE VIEW proyectos_con_etapas_iniciadas AS
(
    SELECT id_proy, cod_area
    from parcial2022_etapa
    WHERE fecha_inicio = current_date
    GROUP BY (id_proy, cod_area)
    HAVING COUNT(*) >= 2
);

select * from proyectos_con_etapas_iniciadas;

select *
from parcial2022_proyecto;
-- insertar en etapa (id_etapa,id_proy, cod_area,descripcion, fecha_inicio, fecha_fin) values ([el id_etapa generalo aleatoriamente, valores desde 50 a 100], 3, 'A003',[la descripcion generala aleatoriamente] current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (50, 3, 'A003', 'etapa 1', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (51, 3, 'A003', 'etapa 2', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (52, 3, 'A003', 'etapa 3', current_date, NULL);


-- insertar en etapa (id_etapa,id_proy, cod_area,descripcion, fecha_inicio, fecha_fin) values ([el id_etapa generalo aleatoriamente, valores desde 50 a 100], 3, 'A009',[la descripcion generala aleatoriamente] current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (53, 9, 'A009', 'etapa 1', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (54, 9, 'A009', 'etapa 2', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (55, 9, 'A009', 'etapa 3', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (56, 9, 'A009', 'etapa 4', current_date, NULL);


-- insertar en etapa (id_etapa,id_proy, cod_area,descripcion, fecha_inicio, fecha_fin) values ([el id_etapa generalo aleatoriamente, valores desde 50 a 100], 3, 'A004',[la descripcion generala aleatoriamente] current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (57, 4, 'A004', 'etapa 1', current_date, NULL);
insert into parcial2022_etapa (id_etapa, id_proy, cod_area, descripcion, fecha_inicio, fecha_fin)
values (58, 4, 'A004', 'etapa 2', current_date, NULL);

select id_etapa, id_proy, cod_area
from parcial2022_etapa;



