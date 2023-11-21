set SEARCH_PATH = "unc_250359";

create or replace procedure parcial2022_uso_recurso_recuento(fecha_minima date)
    language plpgsql
as
$$
begin
    delete from parcial2022_recursos_proyecto where true;
    insert into parcial2022_recursos_proyecto(id_proy, cod_area, nombre_proy, cant_recursos) select p.id_proy, p.cod_area, p.nombre, count(distinct ur.id_recurso)
                                               from parcial2022_uso_recurso ur
                                                        join parcial2022_proyecto p USING (id_proy, cod_area)
                                               where p.fecha_inicio > fecha_minima
                                               group by (p.id_proy, p.cod_area, p.nombre);
end;
$$;

call parcial2022_uso_recurso_recuento(to_date('2023-04-01', 'YYYY-MM-DD'));
select * from parcial2022_recursos_proyecto;


--2023-04-1


-- Para el esquema dado de gestión de proyectos, se ha creado la siguiente tabla Recursos_Proyecto en la que se
-- requiere llevar registro de la cantidad de recursos distintos utilizados por cada uno de los proyectos que se
-- hayan iniciado luego de cierta “fecha de recuento” dada como parámetro.
-- Implemente el método más adecuado en PostgreSQL e incluya una sentencia para la ejecución del mismo.
-- Nota: Tenga en cuenta que en la tabla sólo debe existir la información solicitada para tales proyectos según la
-- fecha indicada y que no puede utilizar sentencias de bucle (for, loop, etc.) para resolverlo.