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


INSERT INTO land (navn) VALUES ('Rwanda');
INSERT INTO land (navn) VALUES ('Colombia');
INSERT INTO region (navn, landID) VALUES ('RwandaRegion', 2);
INSERT INTO region (navn, landID) VALUES ('ColombiaRegion', 3);
INSERT INTO kaffegaard (navn, MOH, regionID) VALUES ('Liguani', 1200, 2);
INSERT INTO kaffegaard (navn, MOH, regionID) VALUES ('Olisium', 1300, 3);
INSERT INTO foredlingsmetode (metodenavn, beskrivelse) VALUES ('vasket','De er vasket');
INSERT INTO kaffeparti (hoesteaar, USDPerKG, gaardsID, metodenavn) VALUES (2010, 10, 2, 'bærtørket');
INSERT INTO kaffeparti (hoesteaar, USDPerKG, gaardsID, metodenavn) VALUES (2017, 2, 3, 'vasket');
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Høstkaffe','lysbrent',20012022,'Digg', 600, 1, 2);
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Sommerkaffe','lysbrent',20012022,'Floral', 600, 1, 3);
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Vinterkaffe','lysbrent',20012022,'floral 123 ', 600, 1, 1);
INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, KaffeID) VALUES ('ikke ordet du skal frem til', 10, 22032022, 1, 2);
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Sommerkaffe 2022','lysbrent',20012022,'ikke ordet', 600, 1, 1);
INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, KaffeID) VALUES ('floral ass bro', 10, 22032022, 1, 3);
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Vårkaffe','mørkbrent',20012022,'floral 123 ', 600, 1, 1);

