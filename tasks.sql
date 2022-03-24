--Brukerhistorie 1

--Brukerhistorie 2
SELECT bruker.fulltNavn, count(DISTINCT kaffesmaking.kaffeID) as ulikeKaffer FROM kaffesmaking
INNER JOIN bruker
ON bruker.brukerID = kaffesmaking.brukerID
GROUP BY bruker.brukerID

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

--Brukerhistorie 5