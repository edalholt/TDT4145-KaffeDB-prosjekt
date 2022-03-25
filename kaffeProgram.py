import sqlite3

con = sqlite3.connect("kaffe.db")
cursor = con.cursor()


def login():
    """"Login"""""
    """ ola@nordmann.no  kaffenorge """
    print("Hei, velkommen til kaffebook")
    #print("Vennligst logg inn")
    #mulighet for å registrere seg 
    #(INSERT INTO bruker (epost, passord, fulltNavn) VALUES ('ola@nordmann.no', 'kaffenorge', 'Ola Nordmann');)
    """ epost = str(input("E-post: "))
    passord = str(input("Passord: "))
    cursor.execute(
        "SELECT brukerID, fulltNavn FROM bruker WHERE epost =? AND passord =?;", (epost, passord))
    brukerdata = cursor.fetchone()
    if (brukerdata):
        program(brukerdata)
    else:
        print("\nDet finner ingen bruker som matcher denne kombinasjonen!")
        done = input('\nVil du prøve på nytt? (y/n)')
        if done == 'n':
            exit()
        login() """
    bhist = str(input('Hvilken brukerhistorie ønsker du å utføre? (1-5) '))
    match bhist:
        case '1':
            pass
        case '2':
            pass
        case '3':
            pass
        case '4':
            Brukerhistorie4()
        case '5':
            Brukerhistorie5()
        
""" En bruker søker etter kaffer som er blitt beskrevet med ordet «floral»,
enten av brukere eller brennerier. Brukeren skal få tilbake en liste med
brennerinavn og kaffenavn. """
""" 
kaffesmaking.notat
ferdigbrent_kaffe.beskrivelse 
"""

def Brukerhistorie4():
    cursor.execute("""SELECT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
FROM ferdigbrendt_kaffe
INNER JOIN kaffebrenneri ON ferdigbrendt_kaffe.brenneriID = kaffebrenneri.brenneriID
WHERE ferdigbrendt_kaffe.beskrivelse LIKE '%floral%'
UNION
SELECT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
FROM kaffesmaking
INNER JOIN ferdigbrendt_kaffe ON ferdigbrendt_kaffe.kaffeID = kaffesmaking.kaffeID
INNER JOIN kaffebrenneri ON ferdigbrendt_kaffe.brenneriID = kaffebrenneri.brenneriID
WHERE kaffesmaking.notat LIKE '%floral%''""")
    brukerdata = cursor.fetchall()
    print(brukerdata)
    fortsett = str(input('Ønsker du å prøve en ny brukerhistorie? (y/n) '))
    match fortsett:
        case 'y':
            login()
        case 'n':
            exit()

""" 
En annen bruker er lei av å bli skuffet av vaskede kaffer og deres tidvis kjedelige smak, og ønsker derfor å søke etter kaffer fra Rwanda
og Colombia som ikke er vaskede. Systemet returnerer en liste over
brennerinavn og kaffenavn.
"""

def Brukerhistorie5():
    cursor.execute("""SELECT DISTINCT ferdigbrendt_kaffe.navn as KaffeNavn, kaffebrenneri.navn as BrenneriNavn
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
WHERE land.navn = 'Rwanda' OR land.navn = 'Colombia' """)
    brukerdata = cursor.fetchall()
    print(brukerdata)
    fortsett = str(input('Ønsker du å prøve en ny brukerhistorie? (y/n) '))
    match fortsett:
        case 'y':
            login()
        case 'n':
            exit()

def program(brukerdata):
    """Main program
    Remember con.commit() after database update
    """
    print("Du er nå logget inn som " + str(brukerdata[1]))
    print('Tast "k" for å opprette en ny kaffesmak-post\nTast "x" for å avslutte')
    while True:
        valg = str(input(""))
        match valg:
            case 'k':
                kaffe_navn = str(input('Hvilken kaffe smakte du på? '))
                byggeri_navn = str(input('Hvilket bryggeri kommer den fra? '))
                poeng = int(input('Hvor mange poeng gir du den?(0-10) '))
                notat = str(input('Legg gjerne til et notat som beskriver kaffen: '))
                #utifra denne dataen skal brukerhistorie 1 oppfylles
                #kaffenavn + bryggeri_navn kan gi kaffeID og bryggeriID   
                pass
            case 'x':
                exit()


def bestCoffeByPrice():
    valg = str(input('Vil du se beste kaffer sammenlignet med pris? (y/n) '))
    match valg:
        case 'y':
            cursor.execute("""
                    SELECT kaffebrenneri.navn AS brennerinavn, ferdigbrendt_kaffe.navn AS kaffenavn, ferdigbrendt_kaffe.kronerPerKg, round((AVG(kaffesmaking.poeng)/ferdigbrendt_kaffe.kronerPerKg )*1000, 2) AS gjennomsnittscore
                    FROM kaffesmaking
                    JOIN ferdigbrendt_kaffe
                    ON kaffesmaking.kaffeID = ferdigbrendt_kaffe.kaffeID
                    JOIN kaffebrenneri
                    ON kaffebrenneri.brenneriID = ferdigbrendt_kaffe.brenneriID
                    GROUP by kaffesmaking.kaffeID
                    ORDER by gjennomsnittscore  DESC""")
            Beste = cursor.fetchall()
            print(Beste)


def main():
    """ Main """
    bestCoffeByPrice()
    print()
    login()

    con.close()


if __name__ == "__main__":
    main()
