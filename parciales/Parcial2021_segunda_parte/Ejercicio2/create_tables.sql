set SEARCH_PATH = "unc_250359";


-- Created by Vertabelo (http://vertabelo.com)

-- tables
-- Table: ADJUNTO
CREATE TABLE PARCIAL2021_ADJUNTO (
                         id_adjunto int  NOT NULL,
                         tamanio int  NOT NULL,
                         ubicacion varchar(30)  NULL,
                         fecha_creacion date  NOT NULL,
                         tipo_adj char(1)  NOT NULL,
                         CONSTRAINT PARCIAL2021_PK_ADJUNTO PRIMARY KEY (id_adjunto)
);

-- Table: Audio
DROP TABLE IF EXISTS PARCIAL2021_Audio CASCADE;
CREATE TABLE PARCIAL2021_Audio (
                       id_adjunto int  NOT NULL,
                       duracion int  NOT NULL,
                       CONSTRAINT PARCIAL2021_PK_audio PRIMARY KEY (id_adjunto)
);

-- Table: Imagen
CREATE TABLE PARCIAL2021_Imagen (
                        id_adjunto int  NOT NULL,
                        resolucion int  NOT NULL,
                        CONSTRAINT PARCIAL2021_PK_video PRIMARY KEY (id_adjunto)
);

-- Table: CONTIENE
CREATE TABLE PARCIAL2021_CONTIENE (
                          id_adjunto int  NOT NULL,
                          tipo_mensaje int  NOT NULL,
                          cod_mensaje int  NOT NULL,
                          descargado char(1)  NULL,
                          CONSTRAINT PARCIAL2021_PK_CONTIENE PRIMARY KEY (id_adjunto,tipo_mensaje,cod_mensaje)
);

-- Table: MENSAJE
CREATE TABLE PARCIAL2021_MENSAJE (
                         tipo_mensaje int  NOT NULL,
                         cod_mensaje int  NOT NULL,
                         asunto varchar(20)  NOT NULL,
                         texto varchar(50)  NOT NULL,
                         es_privado boolean  NOT NULL,
                         CONSTRAINT PARCIAL2021_PARCIAL2021_PK_MENSAJE PRIMARY KEY (tipo_mensaje,cod_mensaje)
);

-- foreign keys
-- Reference: FK_Audio_ADJUNTO (table: Audio)
ALTER TABLE PARCIAL2021_Audio ADD CONSTRAINT FK_Audio_ADJUNTO
    FOREIGN KEY (id_adjunto)
        REFERENCES PARCIAL2021_ADJUNTO (id_adjunto)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: FK_CONTIENE_ADJUNTO (table: CONTIENE)
ALTER TABLE PARCIAL2021_CONTIENE ADD CONSTRAINT FK_CONTIENE_ADJUNTO
    FOREIGN KEY (id_adjunto)
        REFERENCES PARCIAL2021_ADJUNTO (id_adjunto)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: FK_CONTIENE_MENSAJE (table: CONTIENE)
ALTER TABLE PARCIAL2021_CONTIENE ADD CONSTRAINT FK_CONTIENE_MENSAJE
    FOREIGN KEY (tipo_mensaje, cod_mensaje)
        REFERENCES PARCIAL2021_MENSAJE (tipo_mensaje, cod_mensaje)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: FK_Video_ADJUNTO (table: Imagen)
ALTER TABLE PARCIAL2021_Imagen ADD CONSTRAINT FK_Video_ADJUNTO
    FOREIGN KEY (id_adjunto)
        REFERENCES PARCIAL2021_ADJUNTO (id_adjunto)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- End of file.