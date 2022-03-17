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
    cursor.execute("SELECT brukerID, fulltNavn FROM bruker WHERE epost =? AND passord =?;", (epost, passord))
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
                pass
            case 'd':
                pass
            case 'x':
                exit()




def main():
    """ Main """
    login()
    con.close()
    
if __name__ == "__main__":
    main()