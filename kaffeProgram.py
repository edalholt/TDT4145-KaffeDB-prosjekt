import sqlite3
from datetime import date

today = date.today()

con = sqlite3.connect("kaffe.db")
cursor = con.cursor()


def login():
    """"Login"""""
    """ ola@nordmann.no  kaffenorge """
    print("Hei, velkommen til kaffeDB")
    print("Vennligst logg inn")

    epost = str(input("E-post: "))
    passord = str(input("Passord: "))
    cursor.execute(
        "SELECT brukerID, fulltNavn FROM bruker WHERE epost =? AND passord =?;", (epost, passord))
    brukerdata = cursor.fetchone()
    if (brukerdata):
        program(brukerdata)
    else:
        print("\nDet finnes ingen bruker som matcher denne kombinasjonen!")
        done = input('\nVil du prøve på nytt? (y/n)')
        if done == 'n':
            exit()
        login()
        

def program(brukerdata):
    print("Du er nå logget inn som " + str(brukerdata[1]))
    valg = str(input('Hvilken brukerhistorie ønsker du å utføre? (1-5) '))
    match valg:
        case '1':
            brukerhistorie1(brukerdata[0])
        case '2':
            brukerhistorie2()
        case '3':
            brukerhistorie3()
        case '4':
            brukerhistorie4()
        case '5':
            brukerhistorie5()


def brukerhistorie1(brukerID):
    """Sommerkaffe 2021 Oslo kaffebrenneri """
    brenneriNavn = str(input('Kaffebrenneri: '))
    kaffeNavn = str(input('Kaffenavn: '))

    cursor.execute('''SELECT ferdigbrendt_kaffe.kaffeID
                    FROM kaffebrenneri
                    JOIN ferdigbrendt_kaffe
	                ON kaffebrenneri.brenneriID = ferdigbrendt_kaffe.brenneriID
                    WHERE ferdigbrendt_kaffe.navn =? AND kaffebrenneri.navn =?;''', (kaffeNavn, brenneriNavn))

    ferdigKaffe = cursor.fetchone()
    if (not ferdigKaffe):
        print("Det finnes ingen kaffe i databasen med valgt navn")
        login()
    else:
        print("Kaffe finnes i databasen og er valgt")

        notat = str(input('Kaffenotat: '))
        poeng = int(input('Poeng (1-10): '))
        cursor.execute('INSERT INTO kaffesmaking (notat, poeng, dato, brukerID, kaffeID) VALUES (:notat, :poeng, date(), :brukerID, :ferdigKaffe);', {"notat": notat, "poeng": poeng, "brukerID": brukerID, "ferdigKaffe": ferdigKaffe[0]})
        con.commit()
        print("Kaffesmak er opprettet")


def brukerhistorie2():
    cursor.execute(f'''SELECT bruker.fulltNavn, count(DISTINCT kaffesmaking.kaffeID) as ulikeKaffer FROM kaffesmaking
                INNER JOIN bruker
                ON bruker.brukerID = kaffesmaking.brukerID AND date(kaffesmaking.dato) >= date("{today.year}-01-01")
                GROUP BY bruker.brukerID
                ORDER BY ulikeKaffer DESC;''')
    leaderBoard = cursor.fetchall()

    if(len(leaderBoard) < 1):
        print("Ingen kaffesmakinger er registrert")
    else:
        print("\n----Toppliste over de som har smakt flest unike kaffer så langt i år----\n")
        for i in range(len(leaderBoard)):
            print(str(i+1)+".", leaderBoard[i][0], "har drukket", leaderBoard[i][1], "ulike kaffer")
        print("-"*72)
                

def brukerhistorie3():
    cursor.execute("""
                    SELECT kaffebrenneri.navn AS brennerinavn, ferdigbrendt_kaffe.navn AS kaffenavn, ferdigbrendt_kaffe.kronerPerKg, round((AVG(kaffesmaking.poeng)/ferdigbrendt_kaffe.kronerPerKg )*1000, 2) AS gjennomsnittscore
                    FROM kaffesmaking
                    JOIN ferdigbrendt_kaffe
                    ON kaffesmaking.kaffeID = ferdigbrendt_kaffe.kaffeID
                    JOIN kaffebrenneri
                    ON kaffebrenneri.brenneriID = ferdigbrendt_kaffe.brenneriID
                    GROUP by kaffesmaking.kaffeID
                    ORDER by gjennomsnittscore  DESC""")
    beste = cursor.fetchall()
    
    if(len(beste) < 1):
        print("Ingen kaffe er registrert")
    else:
        print("\n----Kaffe som gir mest for pengene sammenlignet med høyest gjennomsnittsscore kontra pris----\n")
        for i in range(len(beste)):
            print(str(i+1)+".", beste[i][0], "med kaffen", beste[i][1], "|Pris:", beste[i][2], "| Poengsum:", beste[i][3], "|")
        print("-"*93)
    

""" En bruker søker etter kaffer som er blitt beskrevet med ordet «floral»,
enten av brukere eller brennerier. Brukeren skal få tilbake en liste med
brennerinavn og kaffenavn. """
def brukerhistorie4():
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

""" 
En annen bruker er lei av å bli skuffet av vaskede kaffer og deres tidvis kjedelige smak, og ønsker derfor å søke etter kaffer fra Rwanda
og Colombia som ikke er vaskede. Systemet returnerer en liste over
brennerinavn og kaffenavn.
"""

def brukerhistorie5():
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


def main():
    """ Main """
    login()
    #program([1, "ola"])
    con.close()


if __name__ == "__main__":
    main()
