-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2023-12-11 02:08:14 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cela (
    numer_celi NUMBER(3) NOT NULL,
    piętro_id  NUMBER NOT NULL,
    id         NUMBER NOT NULL
);

ALTER TABLE cela ADD CONSTRAINT cela_pk PRIMARY KEY ( id );

ALTER TABLE cela ADD CONSTRAINT cela__un UNIQUE ( piętro_id,
                                                  numer_celi );

CREATE TABLE dokumentacja_medyczna (
    data_badania           DATE NOT NULL,
    godzina                TIMESTAMP NOT NULL,
    choroby                VARCHAR2(150),
    sprawowanie            VARCHAR2(150) NOT NULL,
    wymagane_leczenie      VARCHAR2(50),
    osadzony_numer_wieznia NUMBER(3) NOT NULL,
    id                     NUMBER NOT NULL
);

ALTER TABLE dokumentacja_medyczna ADD CONSTRAINT dokumentacja_medyczna_pk PRIMARY KEY ( id );

ALTER TABLE dokumentacja_medyczna
    ADD CONSTRAINT dokumentacja_medyczna__un UNIQUE ( data_badania,
                                                      godzina,
                                                      osadzony_numer_wieznia );

CREATE TABLE dopuscil_sie (
    incydent_id            NUMBER NOT NULL,
    osadzony_numer_wieznia NUMBER(3) NOT NULL
);

ALTER TABLE dopuscil_sie ADD CONSTRAINT dopuscil_sie_pk PRIMARY KEY ( incydent_id,
                                                                      osadzony_numer_wieznia );

CREATE TABLE dyżur (
    godzina_rozpoczecia_zmiany TIMESTAMP NOT NULL,
    godzina_zakonczenia_zmiany TIMESTAMP NOT NULL,
    piętro_id                  NUMBER NOT NULL,
    id                         NUMBER NOT NULL
);

ALTER TABLE dyżur ADD CONSTRAINT dyżur_pk PRIMARY KEY ( id );

ALTER TABLE dyżur
    ADD CONSTRAINT dyżur__un UNIQUE ( godzina_rozpoczecia_zmiany,
                                      godzina_zakonczenia_zmiany,
                                      piętro_id );

CREATE TABLE incydent (
    data            DATE NOT NULL,
    godzina         TIMESTAMP NOT NULL,
    nazwa_incydentu VARCHAR2(30) NOT NULL,
    opis            VARCHAR2(30),
    wiezienie_id    NUMBER NOT NULL,
    id              NUMBER NOT NULL
);

ALTER TABLE incydent ADD CONSTRAINT incydent_pk PRIMARY KEY ( id );

ALTER TABLE incydent
    ADD CONSTRAINT incydent__un UNIQUE ( data,
                                         godzina,
                                         nazwa_incydentu,
                                         wiezienie_id );

CREATE TABLE odbywa_w (
    wydany_wyrok_id NUMBER NOT NULL,
    wiezienie_id    NUMBER NOT NULL
);

ALTER TABLE odbywa_w ADD CONSTRAINT wydany_wyrok_pkv1 PRIMARY KEY ( wydany_wyrok_id,
                                                                    wiezienie_id );

CREATE TABLE odwiedziny (
    imie_odwiedzającego     VARCHAR2(30) NOT NULL,
    nazwisko_odwiedzającego VARCHAR2(30) NOT NULL,
    data_odwiedzin          DATE NOT NULL,
    godzina_odwiedzin       TIMESTAMP NOT NULL,
    osadzony_numer_wieznia  NUMBER(3) NOT NULL,
    id                      NUMBER NOT NULL
);

ALTER TABLE odwiedziny ADD CONSTRAINT odwiedziny_pk PRIMARY KEY ( id );

ALTER TABLE odwiedziny
    ADD CONSTRAINT odwiedziny__un UNIQUE ( data_odwiedzin,
                                           godzina_odwiedzin,
                                           osadzony_numer_wieznia );

CREATE TABLE osadzony (
    numer_wieznia NUMBER(3) NOT NULL,
    imie          VARCHAR2(30) NOT NULL,
    nazwisko      VARCHAR2(30) NOT NULL,
    praca         VARCHAR2(30) NOT NULL
);

ALTER TABLE osadzony ADD CONSTRAINT osadzony_pk PRIMARY KEY ( numer_wieznia );

CREATE TABLE piętro (
    numer_piętra NUMBER(1) NOT NULL,
    id           NUMBER NOT NULL,
    wiezienie_id NUMBER NOT NULL
);

ALTER TABLE piętro ADD CONSTRAINT piętro_pk PRIMARY KEY ( id );

ALTER TABLE piętro ADD CONSTRAINT piętro__un UNIQUE ( numer_piętra,
                                                      wiezienie_id );

CREATE TABLE pobyt_w_celi (
    data_rozpoczecia_pobytu DATE NOT NULL,
    data_konca_pobytu       DATE NOT NULL,
    osadzony_numer_wieznia  NUMBER(3) NOT NULL,
    id                      NUMBER NOT NULL,
    cela_id                 NUMBER NOT NULL
);

ALTER TABLE pobyt_w_celi ADD CONSTRAINT pobyt_w_celi_pk PRIMARY KEY ( id );

ALTER TABLE pobyt_w_celi
    ADD CONSTRAINT pobyt_w_celi__un UNIQUE ( data_rozpoczecia_pobytu,
                                             data_konca_pobytu,
                                             osadzony_numer_wieznia,
                                             cela_id );

CREATE TABLE podczas_nastapil (
    dyżur_id    NUMBER NOT NULL,
    incydent_id NUMBER NOT NULL
);

ALTER TABLE podczas_nastapil ADD CONSTRAINT podczas_nastapil_pk PRIMARY KEY ( dyżur_id,
                                                                              incydent_id );

CREATE TABLE pracownik (
    pesel        VARCHAR2(11) NOT NULL,
    imie         VARCHAR2(30) NOT NULL,
    nazwisko     VARCHAR2(30) NOT NULL,
    funkcja      VARCHAR2(30) NOT NULL,
    wiezienie_id NUMBER NOT NULL,
    id           NUMBER NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id );

ALTER TABLE pracownik ADD CONSTRAINT pracownik__un UNIQUE ( wiezienie_id,
                                                            pesel );

CREATE TABLE pracuje_w (
    dyżur_id     NUMBER NOT NULL,
    pracownik_id NUMBER NOT NULL
);

ALTER TABLE pracuje_w ADD CONSTRAINT pracuje_w_pk PRIMARY KEY ( dyżur_id,
                                                                pracownik_id );

CREATE TABLE przestepstwo (
    nazwa     VARCHAR2(30) NOT NULL,
    min_wyrok VARCHAR2(30) NOT NULL,
    max_wyrok VARCHAR2(30) NOT NULL
);

ALTER TABLE przestepstwo ADD CONSTRAINT przestepstwo_pk PRIMARY KEY ( nazwa );

CREATE TABLE wiezienie (
    nazwa                VARCHAR2(50) NOT NULL,
    adres                VARCHAR2(50) NOT NULL,
    godziny_odwiedzin_od TIMESTAMP NOT NULL,
    godziny_odwiedzin_do TIMESTAMP NOT NULL,
    id                   NUMBER NOT NULL
);

ALTER TABLE wiezienie ADD CONSTRAINT wiezienie_pk PRIMARY KEY ( id );

ALTER TABLE wiezienie ADD CONSTRAINT wiezienie__un UNIQUE ( nazwa,
                                                            adres );

CREATE TABLE wydany_wyrok (
    data_wydania_wyroku         DATE NOT NULL,
    przestepstwo_nazwa          VARCHAR2(30) NOT NULL,
    czas_do_odbycia_w_więzieniu VARCHAR2(30) NOT NULL,
    id                          NUMBER NOT NULL,
    osadzony_numer_wieznia      NUMBER(3) NOT NULL
);

ALTER TABLE wydany_wyrok ADD CONSTRAINT wydany_wyrok_pk PRIMARY KEY ( id );

ALTER TABLE wydany_wyrok
    ADD CONSTRAINT wydany_wyrok__un UNIQUE ( data_wydania_wyroku,
                                             osadzony_numer_wieznia,
                                             przestepstwo_nazwa );

ALTER TABLE cela
    ADD CONSTRAINT cela_piętro_fk FOREIGN KEY ( piętro_id )
        REFERENCES piętro ( id );

ALTER TABLE dokumentacja_medyczna
    ADD CONSTRAINT dok_medyczna_os_fk FOREIGN KEY ( osadzony_numer_wieznia )
        REFERENCES osadzony ( numer_wieznia );

ALTER TABLE dopuscil_sie
    ADD CONSTRAINT dopuscil_sie_incydent_fk FOREIGN KEY ( incydent_id )
        REFERENCES incydent ( id );

ALTER TABLE dopuscil_sie
    ADD CONSTRAINT dopuscil_sie_osadzony_fk FOREIGN KEY ( osadzony_numer_wieznia )
        REFERENCES osadzony ( numer_wieznia );

ALTER TABLE dyżur
    ADD CONSTRAINT dyżur_piętro_fk FOREIGN KEY ( piętro_id )
        REFERENCES piętro ( id );

ALTER TABLE incydent
    ADD CONSTRAINT incydent_wiezienie_fk FOREIGN KEY ( wiezienie_id )
        REFERENCES wiezienie ( id );

ALTER TABLE odwiedziny
    ADD CONSTRAINT odwiedziny_osadzony_fk FOREIGN KEY ( osadzony_numer_wieznia )
        REFERENCES osadzony ( numer_wieznia );

ALTER TABLE piętro
    ADD CONSTRAINT piętro_wiezienie_fk FOREIGN KEY ( wiezienie_id )
        REFERENCES wiezienie ( id );

ALTER TABLE pobyt_w_celi
    ADD CONSTRAINT pobyt_w_celi_cela_fk FOREIGN KEY ( cela_id )
        REFERENCES cela ( id );

ALTER TABLE pobyt_w_celi
    ADD CONSTRAINT pobyt_w_celi_osadzony_fk FOREIGN KEY ( osadzony_numer_wieznia )
        REFERENCES osadzony ( numer_wieznia );

ALTER TABLE podczas_nastapil
    ADD CONSTRAINT podczas_nastapil_dyżur_fk FOREIGN KEY ( dyżur_id )
        REFERENCES dyżur ( id );

ALTER TABLE podczas_nastapil
    ADD CONSTRAINT podczas_nastapil_incydent_fk FOREIGN KEY ( incydent_id )
        REFERENCES incydent ( id );

ALTER TABLE pracownik
    ADD CONSTRAINT pracownik_wiezienie_fk FOREIGN KEY ( wiezienie_id )
        REFERENCES wiezienie ( id );

ALTER TABLE pracuje_w
    ADD CONSTRAINT pracuje_w_dyżur_fk FOREIGN KEY ( dyżur_id )
        REFERENCES dyżur ( id );

ALTER TABLE pracuje_w
    ADD CONSTRAINT pracuje_w_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

ALTER TABLE wydany_wyrok
    ADD CONSTRAINT wydany_wyrok_osadzony_fk FOREIGN KEY ( osadzony_numer_wieznia )
        REFERENCES osadzony ( numer_wieznia );

ALTER TABLE wydany_wyrok
    ADD CONSTRAINT wydany_wyrok_przestepstwo_fk FOREIGN KEY ( przestepstwo_nazwa )
        REFERENCES przestepstwo ( nazwa );

ALTER TABLE odbywa_w
    ADD CONSTRAINT wydany_wyrok_wiezienie_fk FOREIGN KEY ( wiezienie_id )
        REFERENCES wiezienie ( id );

ALTER TABLE odbywa_w
    ADD CONSTRAINT wydany_wyrok_wydany_wyrok_fk FOREIGN KEY ( wydany_wyrok_id )
        REFERENCES wydany_wyrok ( id );

CREATE OR REPLACE PROCEDURE dodaj_nowy_incydent(
    p_data DATE,
    p_godzina TIMESTAMP,
    p_nazwa_incydentu VARCHAR2,
    p_opis VARCHAR2,
    p_wiezienie_id NUMBER
) AS
BEGIN
    INSERT INTO incydent (data, godzina, nazwa_incydentu, opis, wiezienie_id)
    VALUES (p_data, p_godzina, p_nazwa_incydentu, p_opis, p_wiezienie_id);
END dodaj_nowy_incydent;

CREATE OR REPLACE FUNCTION pobierz_nazwisko_wieznia(
    p_numer_wieznia NUMBER
) RETURN VARCHAR2 AS
    v_nazwisko VARCHAR2(30);
BEGIN
    SELECT nazwisko INTO v_nazwisko
    FROM osadzony
    WHERE numer_wieznia = p_numer_wieznia;

    RETURN v_nazwisko;
END pobierz_nazwisko_wieznia;

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             45
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         1
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0