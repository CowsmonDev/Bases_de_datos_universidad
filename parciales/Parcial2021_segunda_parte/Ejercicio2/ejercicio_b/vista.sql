set search_path = "unc_250359";
-- Dada la siguiente vista sobre el esquema dado:
-- create view VISTA_3 as
-- select a.id_adjunto, a.tipo_adj, a.tamanio, a.fecha_creacion, ai.resolucion as dimension
-- from adjunto a join imagen ai on a.id_adjunto = ai.id_adjunto
-- union
-- select a.id_adjunto, a.tipo_adj, a.tamanio, a.fecha_creacion, aa.duracion as dimension
-- from adjunto a join audio aa on a.id_adjunto = aa.id_adjunto;

create view PARCIAL_2021_VISTA_3 as (
        select a.id_adjunto, a.tipo_adj, a.tamanio, a.fecha_creacion, ai.resolucion as dimension
        from parcial2021_adjunto a
                 join parcial2021_imagen ai using (id_adjunto)
    union
        select a.id_adjunto, a.tipo_adj, a.tamanio, a.fecha_creacion, aa.duracion as dimension
        from parcial2021_adjunto a
                 join parcial2021_audio aa using (id_adjunto)
);


-- creamos un trigger que elimine el registro de audio e imagen y tambien compruebe si estaba en ambos
-- en caso negativo, eliminar el registro de adjunto