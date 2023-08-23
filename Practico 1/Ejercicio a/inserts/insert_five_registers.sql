-- insertar 5 registros con todos los campos dentro de la tabla palabra_tp_1_table_a
INSERT INTO palabra_tp_1_table_a(cod_p, idioma, descripcion) VALUES
                                        (1, 'es', 'saludo en español'),
                                        (2, 'in', 'saludo en ingles'),
                                        (3, 'in', 'despedida en ingles'),
                                        (4, 'es', 'despedida en español'),
                                        (5, 'es', 'lugar en español');

-- insertar 5 registros con todos los campos dentro de la tabla Articulo_tp_1_table_b
INSERT INTO articulo_tp_1_table_a(id_articulo, titulo, autor, fecha_pub) VALUES
                                        (1, 'titulo 1', 'autor 1', '2019-01-01'),
                                        (2, 'titulo 2', 'autor 2', '2019-01-02'),
                                        (3, 'titulo 3', 'autor 3', '2019-01-03'),
                                        (4, 'titulo 4', 'autor 4', '2019-01-04'),
                                        (5, 'titulo 5', 'autor 5', '2019-01-05');

-- insertar 5 registros con todos los campos dentro de la tabla contiene_tp_1_table_b
INSERT INTO contiene_tp_1_table_a(id_articulo, cod_p, idioma) VALUES
                                        (1, 1, 'es'),
                                        (1, 2, 'in'),
                                        (2, 2, 'in'),
                                        (2, 3, 'in'),
                                        (3, 3, 'in');