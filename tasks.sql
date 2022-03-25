--Brukerhistorie 1

SELECT kaffebrenneri.navn, kaffebrenneri.brenneriID, ferdigbrendt_kaffe.kaffeID
FROM kaffebrenneri
JOIN ferdigbrendt_kaffe
	ON kaffebrenneri.brenneriID = ferdigbrendt_kaffe.brenneriID
WHERE ferdigbrendt_kaffe.navn = "Sommerkaffe 2021" AND kaffebrenneri.navn = "Jacobsen & Svart";

INSERT INTO kaffesmaking (notat,poeng, dato, brukerID, kaffeID) VALUES ();


--Brukerhistorie 2 - Bytt ut 2022 med current year i python
SELECT bruker.fulltNavn, count(DISTINCT kaffesmaking.kaffeID) as ulikeKaffer FROM kaffesmaking
INNER JOIN bruker
ON bruker.brukerID = kaffesmaking.brukerID AND date(kaffesmaking.dato) >= date('2022-01-01')
GROUP BY bruker.brukerID
ORDER BY ulikeKaffer ASC

--Brukerhistorie 3
SELECT  kaffebrenneri.navn AS brennerinavn, ferdigbrendt_kaffe.navn AS kaffenavn, ferdigbrendt_kaffe.kronerPerKg, round((AVG(kaffesmaking.poeng)/ferdigbrendt_kaffe.kronerPerKg )*1000, 2) AS gjennomsnittscore
FROM kaffesmaking
JOIN ferdigbrendt_kaffe
	ON kaffesmaking.kaffeID = ferdigbrendt_kaffe.kaffeID
JOIN kaffebrenneri
	ON kaffebrenneri.brenneriID = ferdigbrendt_kaffe.brenneriID
	
GROUP by kaffesmaking.kaffeID
ORDER by gjennomsnittscore  DESC

--Brukerhistorie 4
SELECT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
FROM ferdigbrendt_kaffe
INNER JOIN kaffebrenneri ON ferdigbrendt_kaffe.brenneriID = kaffebrenneri.brenneriID
WHERE ferdigbrendt_kaffe.beskrivelse LIKE '%floral%'
UNION
SELECT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
FROM kaffesmaking
INNER JOIN ferdigbrendt_kaffe ON ferdigbrendt_kaffe.kaffeID = kaffesmaking.kaffeID
INNER JOIN kaffebrenneri ON ferdigbrendt_kaffe.brenneriID = kaffebrenneri.brenneriID
WHERE kaffesmaking.notat LIKE '%floral%'

--Brukerhistorie 5
SELECT DISTINCT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
FROM ferdigbrendt_kaffe
INNER JOIN kaffeparti
ON ferdigbrendt_kaffe.partiID = kaffeparti.partiID
INNER JOIN foredlingsmetode
ON kaffeparti.metodenavn != 'vasket'
INNER JOIN kaffebrenneri
ON ferdigbrendt_kaffe.brenneriID = kaffebrenneri.brenneriID
INNER JOIN kaffegaard
ON kaffeparti.gaardsID = kaffegaard.gaardsID
INNER JOIN region
ON kaffegaard.regionID = region.regionID
INNER JOIN land
ON land.landID = region.regionID
WHERE land.navn = 'Rwanda' OR land.navn = 'Colombia'