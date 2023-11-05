set search_path = "unc_250359";

-- Se requiere controlar que en las etapas descriptas como de “analisis...” iniciadas posteriormente al 31/oct/22 no
-- se utilicen recursos cuyo nombre contenga “vista” sin que se registre una observación.

create or replace function f_observacion()
    returns trigger as
$$
begin
    if (
            exists(select 1
             from parcial2022_etapa
             where descripcion = 'analisis...'
               and fecha_inicio > to_date('31/10/2022', 'dd/mm/yyyy'))
            AND
            exists(select 1 from parcial2022_recurso where lower(nombre) like '%vista%')
        ) then
        raise exception 'Se requiere una observacion';
    end if;
end;
$$ language plpgsql;

create or replace trigger trg_observacion
    before insert
    on parcial2022_uso_recurso
    for each row
    when (new.observacion is null)
execute function f_observacion();

select descripcion, fecha_inicio
from parcial2022_etapa
where descripcion = 'analisis...'
  and fecha_inicio > to_date('31/10/2022', 'dd/mm/yyyy');

select *
from parcial2022_recurso
where lower(nombre) like '%vista%'