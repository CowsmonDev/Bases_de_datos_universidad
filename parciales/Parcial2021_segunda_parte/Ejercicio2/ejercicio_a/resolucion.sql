set SEARCH_PATH = "unc_250359";

-- a.1) VISTA_1, que contenga los datos de los mensajes privados con asunto iniciado en 'consulta' que contienen
-- algún archivo adjunto de imagen creado el año actual.

select *
from parcial2021_mensaje m
where asunto like 'consulta%'
  and es_privado
  and (cod_mensaje, tipo_mensaje) in (select cod_mensaje, tipo_mensaje
                                      from parcial2021_contiene c
                                               join parcial2021_adjunto a using (id_adjunto)
                                      where extract(year from fecha_creacion) = extract(year from current_date)
                                        and lower(tipo_adj) = 'i');


--a.2) VISTA_2, con el identificador y texto de todos los mensajes junto con la cantidad de archivos
--descargados que tienen adjuntos, si es que poseen.

select cod_mensaje, tipo_mensaje, texto, coalesce(cantidad_adjuntos, 0) as cantidad_adjuntos
from parcial2021_mensaje m
         left join (select cod_mensaje, tipo_mensaje, count(id_adjunto) as cantidad_adjuntos
                    from parcial2021_contiene
                    where descargado is not null
                    group by cod_mensaje, tipo_mensaje) as cc using (cod_mensaje, tipo_mensaje);