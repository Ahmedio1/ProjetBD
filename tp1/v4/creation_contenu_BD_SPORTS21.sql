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
SELECT count(*)
	    FROM sport
	    GROUP BY categorie;

INSERT INTO t_nb_sports_par_categorie VALUES
('Athlétisme',2),
('Collectif',3),
('Art martial',2),
('Cyclisme',1);

SELECT *
FROM t_nb_sports_par_categorie;

DELETE
FROM SPORT
WHERE id_sport IN (0,5);

SELECT *
FROM SPORT;

SELECT *
FROM T_NB_SPORTS_PAR_CATEGORIE
ORDER BY categorie;

SELECT *
FROM V_NB_SPORTS_PAR_CATEGORIE;