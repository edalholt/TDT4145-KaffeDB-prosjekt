import sqlite3

con = sqlite3.connect("kaffe.db")
cursor = con.cursor()

con.commit()
con.close()