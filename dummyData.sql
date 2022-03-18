INSERT INTO bruker (epost, passord, fulltNavn) VALUES ('ola@nordmann.no', 'kaffenorge', 'Ola Nordmann');
INSERT INTO land (navn) VALUES ('El Salvador');
INSERT INTO region (navn, landID) VALUES ('Santa Ana', 1);
INSERT INTO kaffegaard (navn, MOH, regionID) VALUES ('Nombre de Dios', 1500, 1);
INSERT INTO brenningsgrad (brenningsgrad) VALUES ('lysbrent');
INSERT INTO brenningsgrad (brenningsgrad) VALUES ('medium brent');
INSERT INTO brenningsgrad (brenningsgrad) VALUES ('mørkbrent');
INSERT INTO foredlingsmetode (metodenavn, beskrivelse) VALUES ('bærtørket','Hele Kaffebæret tørkes. Med denne prosesseringen fjernes verken skallet eller fruktkjøttet før tørking. Denne prosesseringen gir ofte mer fyldige kaffe med stor munnfølelse. Denne prosesseringen kalles også for Natural.');
INSERT INTO kaffeparti (hoesteaar, USDPerKG, gaardsID, metodenavn) VALUES (2021, 8, 1, 'bærtørket');
INSERT INTO kaffeboenne (art) VALUES ('coffea arabica');
INSERT INTO kaffesort (navn, art) VALUES ('Bourbon', 'coffea arabica');
INSERT INTO kaffebrenneri (navn) VALUES ('Jacobsen & Svart');
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Vinterkaffe 2022','lysbrent',20012022,'Bærsøt og delikat med toner av tørket frukt, røde hagebær og karamell.', 600, 1, 1);
INSERT INTO dyrkesAv (art, gaardsID) VALUES ('coffea arabica', 1);
INSERT INTO bestaarAv (art, partiID) VALUES ('coffea arabica', 1);
INSERT INTO sendesTil (brenneriID, partiID) VALUES (1, 1);

