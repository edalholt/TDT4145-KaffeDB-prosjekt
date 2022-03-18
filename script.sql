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

