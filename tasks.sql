--Brukerhistorie 1

--Brukerhistorie 2
SELECT bruker.fulltNavn, count(DISTINCT kaffesmaking.kaffeID) as ulikeKaffer FROM kaffesmaking
INNER JOIN bruker
ON bruker.brukerID = kaffesmaking.brukerID
GROUP BY bruker.brukerID

--Brukerhistorie 3

--Brukerhistorie 4

--Brukerhistorie 5