set search_path = "unc_250359";

create or replace function functionUsuarioTareaRealizada()
    returns trigger as
$$
begin
    if (TG_OP = 'INSERT') then
        insert into tarea(id_tarea, nombre_tarea, min_horas, max_horas)
        values (new.id_tarea, new.nombre_tarea, new.min_horas, new.max_horas);
    elseif (TG_OP = 'UPDATE') then
        update voluntario
        set
            nro_voluntario = new.nro_voluntario,
            nombre          = new.nombre,
            apellido        = new.apellido,
            horas_aportadas = new.horas_aportadas,
            id_tarea        = new.id_tarea
        where nro_voluntario = old.nro_voluntario;
    elseif (TG_OP = 'DELETE') then
        delete from voluntario
        where nro_voluntario = old.id_voluntario;
    end if;
end;

$$ language plpgsql;


create trigger TiggerUsuarioTareaRealizada
    instead of insert or update or delete
    on usuariotarearealizada
    for each row
execute
