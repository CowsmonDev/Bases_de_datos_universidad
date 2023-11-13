set search_path = "unc_250359";

-- se puede borrar de audio o imagen ya que si se borra de adjunto, no se sabe cual estara borrando

create or replace function f_borrar_adjunto()
returns trigger as
$$
    declare
        i_adjunto integer;
        a_adjunto integer;
    begin
        select count(*) into i_adjunto from parcial2021_imagen where id_adjunto = old.id_adjunto;
        select count(*) into a_adjunto from parcial2021_audio where id_adjunto = old.id_adjunto;
        if(i_adjunto = 1) then
            delete from parcial2021_imagen where id_adjunto = old.id_adjunto;
        end if;
        if(a_adjunto = 1) then
            delete from parcial2021_audio where id_adjunto = old.id_adjunto;
        end if;
        if i_adjunto = 0 or a_adjunto = 0 then
            delete from parcial2021_adjunto where id_adjunto = old.id_adjunto;
        end if;
    end;
$$ language plpgsql;