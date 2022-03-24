import sqlite3

con = sqlite3.connect("kaffe.db")
cursor = con.cursor()


def login():
    """"Login"""""
    """ ola@nordmann.no  kaffenorge """
    print("Hei, velkommen til kaffebook")
    print("Vennligst logg inn")
    epost = str(input("E-post: "))
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
        login()


def program(brukerdata):
    """Main program
    Remember con.commit() after database update
    """
    print("Du er nå logget inn som " + str(brukerdata[1]))
    print('Tast "k" for å opprette en ny kaffesmak-post\nTast "d" for å legge inn ny data\nTast "x" for å avslutte')
    while True:
        valg = str(input(""))
        match valg:
            case 'k':
                kaffe_navn = str(input('Hvilken kaffe smakte du på? '))
                byggeri_navn = str(input('Hvilket bryggeri kommer den fra? '))
                poeng = int(input('Hvor mange poeng gir du den?(0-10) '))
                notat = str(
                    input('Legg gjerne til et notat som beskriver kaffen: '))
                # utifra denne dataen skal brukerhistorie 1 oppfylles
                pass
            case 'd':
                print('Så spennende med ny data!')
                valg = str(input('''Hva vil du legge inn data om?\n
                '''))
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
