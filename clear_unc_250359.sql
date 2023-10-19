
CREATE OR REPLACE PROCEDURE clear_all_tables()
AS $$
DECLARE
    registro RECORD;
BEGIN
    -- Abre un cursor para la consulta
    FOR registro IN (SELECT tablename FROM pg_tables WHERE schemaname = 'unc_250359')
    LOOP
        -- Dentro del bucle, puedes acceder al valor del campo mi_campo de cada registro
        -- Hacer algo con registro.mi_campo
        -- Por ejemplo, imprimir el valor
        EXECUTE 'DROP TABLE IF EXISTS unc_250359.' || registro.tablename || ' CASCADE';
    END LOOP;
END;
$$ LANGUAGE plpgsql;


call clear_all_tables();