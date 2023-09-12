SELECT
    (apellido||' '|| nombre) as "Apellido y Nombre",
    e_mail as "Direccion de mail" FROM voluntario
WHERE telefono LIKE '+11%'