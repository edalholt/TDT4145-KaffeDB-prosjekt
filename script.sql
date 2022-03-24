CREATE TABLE "land" (
	"landID"	INTEGER NOT NULL UNIQUE,
	"navn"	TEXT NOT NULL,
	PRIMARY KEY("landID")
);

CREATE TABLE "region" (
	"regionID"	INTEGER NOT NULL UNIQUE,
	"navn"	TEXT NOT NULL,
	"landID"	INTEGER NOT NULL,
	PRIMARY KEY("regionID" AUTOINCREMENT),
	FOREIGN KEY("landID") REFERENCES "land"("landID")
);

CREATE TABLE "kaffegaard" (
	"gaardsID"	INTEGER NOT NULL UNIQUE,
	"navn"	TEXT NOT NULL,
	"MOH"	INTEGER NOT NULL,
	"regionID"	INTEGER NOT NULL,
	FOREIGN KEY("regionID") REFERENCES "region"("regionID"),
	PRIMARY KEY("gaardsID" AUTOINCREMENT)
);

CREATE TABLE "kaffeboenne" (
	"art"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("art")
);

CREATE TABLE "kaffesort" (
	"navn"	TEXT NOT NULL UNIQUE,
	"art"	TEXT NOT NULL,
	FOREIGN KEY("art") REFERENCES "kaffeboenne"("art"),
	PRIMARY KEY("navn")
);

CREATE TABLE "foredlingsmetode" (
	"metodenavn"	TEXT NOT NULL UNIQUE,
	"beskrivelse"	TEXT NOT NULL,
	PRIMARY KEY("metodenavn")
);

CREATE TABLE "kaffeparti" (
	"partiID"	INTEGER NOT NULL UNIQUE,
	"hoesteaar"	INTEGER NOT NULL,
	"USDPerKg"	INTEGER NOT NULL,
	"gaardsID"	INTEGER NOT NULL,
	"metodenavn"	TEXT NOT NULL,
	FOREIGN KEY("metodenavn") REFERENCES "foredlingsmetode"("metodenavn"),
	PRIMARY KEY("partiID" AUTOINCREMENT)
);

CREATE TABLE "dyrkesAv" (
	"art"	TEXT NOT NULL,
	"gaardsID"	INTEGER NOT NULL,
	FOREIGN KEY("gaardsID") REFERENCES "kaffegaard"("gaardsID"),
	FOREIGN KEY("art") REFERENCES "kaffeboenne"("art")
);

CREATE TABLE "bestaarAv" (
	"art"	TEXT NOT NULL,
	"partiID"	INTEGER NOT NULL,
	FOREIGN KEY("partiID") REFERENCES "kaffeparti"("partiID"),
	FOREIGN KEY("art") REFERENCES "kaffeboenne"("art")
);

CREATE TABLE "kaffebrenneri" (
	"brenneriID"	INTEGER NOT NULL UNIQUE,
	"navn"	TEXT NOT NULL,
	PRIMARY KEY("brenneriID" AUTOINCREMENT)
);

CREATE TABLE "sendesTil" (
	"brenneriID"	INTEGER NOT NULL,
	"partiID"	INTEGER NOT NULL,
	FOREIGN KEY("brenneriID") REFERENCES "kaffebrenneri"("brenneriID"),
	FOREIGN KEY("partiID") REFERENCES "kaffeparti"("partiID")
);

CREATE TABLE "brenningsgrad" (
	"brenningsgrad"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("brenningsgrad")
);

CREATE TABLE "ferdigbrendt_kaffe" (
	"kaffeID"	INTEGER NOT NULL UNIQUE,
	"navn"	TEXT NOT NULL,
	"brenningsgrad"	TEXT NOT NULL,
	"dato"	INTEGER NOT NULL,
	"beskrivelse"	TEXT NOT NULL,
	"kronerPerKg"	INTEGER NOT NULL,
	"brenneriID"	INTEGER NOT NULL,
	"partiID"	INTEGER NOT NULL,
	PRIMARY KEY("kaffeID" AUTOINCREMENT),
	FOREIGN KEY("partiID") REFERENCES "kaffeparti"("partiID"),
	FOREIGN KEY("brenneriID") REFERENCES "kaffebrenneri"("brenneriID"),
	FOREIGN KEY("brenningsgrad") REFERENCES "brenningsgrad"("brenningsgrad")
);

CREATE TABLE "bruker" (
	"brukerID"	INTEGER NOT NULL UNIQUE,
	"epost"	TEXT NOT NULL,
	"passord"	TEXT NOT NULL,
	"fulltNavn"	TEXT NOT NULL,
	PRIMARY KEY("brukerID" AUTOINCREMENT)
);

CREATE TABLE "kaffesmaking" (
	"smakID"	INTEGER NOT NULL UNIQUE,
	"notat"	TEXT NOT NULL,
	"poeng"	INTEGER NOT NULL,
	"dato"	INTEGER NOT NULL,
	"brukerID"	INTEGER NOT NULL,
	"kaffeID"	INTEGER NOT NULL,
	FOREIGN KEY("brukerID") REFERENCES "bruker"("brukerID"),
	FOREIGN KEY("kaffeID") REFERENCES "ferdigbrendt_kaffe"("kaffeID"),
	PRIMARY KEY("smakID" AUTOINCREMENT)
);

--Dummy data
INSERT INTO bruker (epost, passord, fulltNavn) VALUES ('ola@nordmann.no', 'kaffenorge', 'Ola Nordmann');
INSERT INTO bruker (epost, passord, fulltNavn) VALUES ('bob@nordmann.no', 'kaffe', 'Bob Nordmann');
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
INSERT INTO kaffebrenneri (navn) VALUES ('Oslo kaffebrenneri');
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Vinterkaffe 2022','lysbrent',date('2022-03-10'),'Bærsøt og delikat med toner av tørket frukt, røde hagebær og karamell.', 600, 1, 1);
INSERT INTO ferdigbrendt_kaffe (navn, brenningsgrad,dato,beskrivelse,kronerPerKg,brenneriID, partiID) VALUES ('Sommerkaffe 2021','lysbrent',date('2021-07-10'),'god', 300, 2, 1);
INSERT INTO dyrkesAv (art, gaardsID) VALUES ('coffea arabica', 1);
INSERT INTO bestaarAv (art, partiID) VALUES ('coffea arabica', 1);
INSERT INTO sendesTil (brenneriID, partiID) VALUES (1, 1);

--Ekstra
INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, kaffeID) VALUES ('veldig god', 10, date(), 1, 1);
INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, kaffeID) VALUES ('ganske god', 5, date('2022-02-10'), 1, 2);
INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, kaffeID) VALUES ('God nok', 8, date('2022-02-10'), 1, 2);




