set search_path = "unc_250359";

-- a) vista_proy_12: que contenga los datos de los proyectos de más de 12 meses de duración, con un
-- presupuesto superior a 5000 y que no utilizan recursos.

-- insertar un proyecto que cumpla con esas caracteristicas
CREATE VIEW parcial2022_vista_proy_12 AS
(
    select id_proy, cod_area, nombre, presupuesto, fecha_inicio, fecha_fin
    from parcial2022_proyecto p
    where extract(year from age(fecha_fin, fecha_inicio)) > 0
      and presupuesto > 5000
      and not exists (select 1 from parcial2022_uso_recurso ur where p.id_proy = ur.id_proy and p.cod_area = ur.cod_area)
);

-- probar funcionamiento de la vista
select * from parcial2022_vista_proy_12;

-- inserta una etapa para el proyecto 100 del area A004
insert into parcial2022_etapa(id_proy, cod_area, id_etapa, descripcion, fecha_inicio, fecha_fin)
values (100, 'A004', 1, 'etapa 1', '2021-01-01', '2021-02-01');
-- inserta un uso de recurso para la etapa 1 del proyecto 100 del area A004
insert into parcial2022_uso_recurso(id_etapa, id_proy, cod_area, id_recurso, observacion)
values (1, 100, 'A004', 'R004', 'observacion 1');
-- elimina el uso para probar funcionamiento
delete
from parcial2022_uso_recurso
where id_proy = 100
  and cod_area = 'A004'
  and id_etapa = 1
  and id_recurso = 'R004';

-- b) vista_area_pr: con el identificador y nombre de todas las áreas existentes, junto con el presupuesto
-- promedio de los proyectos iniciados durante el corriente año, correspondientes a cada área. En caso de no
-- poseer, debe indicarse que tal presupuesto es cero.

select a.cod_area, a.nom_area, coalesce(pp.presupuesto_promedio, 0) from parcial2022_area a
left join (
    select cod_area, avg(presupuesto) as presupuesto_promedio
    from parcial2022_proyecto
    where extract(year from fecha_inicio) = extract(year from current_date)
    group by cod_area
) as pp on a.cod_area = pp.cod_area;

select cod_area, avg(presupuesto) from parcial2022_proyecto
where extract(year from fecha_inicio) = extract(year from current_date)
group by cod_area;