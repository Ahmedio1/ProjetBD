-- Tests pour l'étape 4
-- Jean-François Condotta - 2021

\echo '\n*** Contenus initiaux des tables SPORT et T_NB_SPORTS_PAR_CATEGORIE ***\n'

SELECT *
FROM SPORT;

SELECT *
FROM T_NB_SPORTS_PAR_CATEGORIE;

INSERT INTO SPORT VALUES
(0,'Marche','Athlétisme'),
(1,'Rugby','Collectif'),
(2,'Football','Collectif'),
(3,'Karaté','Art martial'),
(4,'Course à pied','Athlétisme'),
(5,'VTT','Cyclisme'),
(6,'Judo','Art martial'),
(7,'Volley-ball','Collectif')
;

\echo '\n*** Contenus de SPORT, T_NB_SPORTS_PAR_CATEGORIE et V_NB_SPORTS_PAR_CATEGORIE après des insertions ***\n'

\echo '\n*** SPORT ***'
SELECT *
FROM SPORT;
\echo '\n*** T_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM T_NB_SPORTS_PAR_CATEGORIE
ORDER BY categorie;
\echo '\n*** V_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM V_NB_SPORTS_PAR_CATEGORIE;

DELETE
FROM SPORT 
WHERE id_sport IN (0,5);

\echo '\n*** Contenus de SPORT, T_NB_SPORTS_PAR_CATEGORIE et V_NB_SPORTS_PAR_CATEGORIE après des suppressions ***\n'

\echo '\n*** SPORT ***'
SELECT *
FROM SPORT;
\echo '\n*** T_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM T_NB_SPORTS_PAR_CATEGORIE
ORDER BY categorie;
\echo '\n*** V_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM V_NB_SPORTS_PAR_CATEGORIE;


UPDATE SPORT
SET id_sport=20
WHERE id_sport=1;

UPDATE SPORT
SET categorie='Collectif'
WHERE id_sport=3;

UPDATE SPORT
SET categorie='Super Art Martial'
WHERE id_sport=6;

\echo '\n*** Contenus de SPORT, T_NB_SPORTS_PAR_CATEGORIE et V_NB_SPORTS_PAR_CATEGORIE après des updates ***\n'

\echo '\n*** SPORT ***'
SELECT *
FROM SPORT;
\echo '\n*** T_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM T_NB_SPORTS_PAR_CATEGORIE
ORDER BY categorie;
\echo '\n*** V_NB_SPORTS_PAR_CATEGORIE ***'
SELECT *
FROM V_NB_SPORTS_PAR_CATEGORIE;

