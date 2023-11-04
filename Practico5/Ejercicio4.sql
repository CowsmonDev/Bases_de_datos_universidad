set search_path = "unc_250359";

CREATE OR REPLACE VIEW tarea10000hs AS
    SELECT * FROM tarea
    WHERE max_horas > 10000
    WITH LOCAL CHECK OPTION;

CREATE OR REPLACE VIEW tarea10000rep AS
    SELECT * FROM tarea10000hs
    WHERE id_tarea LIKE '%REP%'
    WITH LOCAL CHECK OPTION;

-- no va a funcionar porque viola el check de tarea10000rep
INSERT INTO tarea10000rep (id_tarea, nombre_tarea, min_horas, max_horas)
    VALUES ('MGR', 'Org Salud', 18000, 20000);

-- no va a funcionar porque viola el check de tarea10000hs
INSERT INTO tarea10000hs (id_tarea, nombre_tarea, min_horas, max_horas)
    VALUES ('REPA', 'Organiz Salud', 4000, 5500);

-- no va a funcionar porque viola el check de tarea10000hs
INSERT INTO tarea10000rep (id_tarea, nombre_tarea, min_horas, max_horas)
    VALUES('CC_REP', 'Organizacion Salud', 8000, 9000);

-- va a insertar correctamente
INSERT INTO tarea10000hs (id_tarea, nombre_tarea, min_horas, max_horas)
VALUES ('ROM', 'Org Salud', 10000, 12000);
DELETE from tarea10000hs where id_tarea = 'ROM';