# Sukurti Python programą, kuri:


# !!! Sukurtų duomenų bazę ir atliktų nurodytus veiksmus su ja, pasirinktu duomenų bazės apdorojimo principu, naudojant užklausas (sqlite3), arba Pandas data frame.

# 1. Sukurtų lentelę Saldainiai su stulpeliais: Pavadinimis, Tipas, Kaina/kg, Perkamas kiekis, Kaina.
# 2. Sukurtų 10 saldainių: pasirinktai užpildykite ("Miglė", "Šokoladinis", 6, 2,) ir t.t.. Ps. (Kainą apskaičiuosime ir įtrauksime)
# 3. Užpildykite stulpelį Kaina įtraukdami apskaičiuotas sumos vertes prie atitinkamo saldainio.
# 4. Atspausdintų tik tuos saldainius kurių tipas "Šokoladinis" ir kaina > 5 eur.
# 5. Panaikintų input pagalba įvesto saldainio pavadinimimo duomenis - ištrintų visą eilutę lentelėje apie tą saldainį.
# 6. Spausdinkite tarpinius rezultatus kiekvieną eilutę atskirai. Pvz.
# ("Miglė", "Šokoladinis", 6, 2,)
# ("Miglė", "Šokoladinis", 6, 2,)
# ("Miglė", "Šokoladinis", 6, 2,)
# ...
# 7. Naudodamiesi Seaborn arba Matplotlib Python bibliotekomis, atvaizduokite bent du grafikus (skirtingų tipų - linijinių, stulpelinių, taškinių ar kt. ) Kaina/Saldainis. 
# Pakaitaliokite grafikų parametrus, pvz. spalvų paletė. Grafikai turi turėti ašių pavadinimus, vertes ant ašių, pavadinimą. Dar gali turėti legentdą ar kt. pasirinktą info.


import sqlite3

conn = sqlite3.connect("duomenu_baze_saldainiai1.db")
c = conn.cursor()

#1. Sukurtų lentelę Saldainiai su stulpeliais: Pavadinimis, Tipas, Kaina/kg, Perkamas kiekis, Kaina.
with conn:
    c.execute("CREATE TABLE IF NOT EXISTS Saldainiai\
               (Pavadinimas TEXT UNIQUE, Tipas TEXT, Perkamas_kiekis integer, Kaina_kg integer, Kaina integer)")

#2. Sukurtų 10 saldainių: pasirinktai užpildykite ("Miglė", "Šokoladinis", 6, 2,) ir t.t.. Ps. (Kainą apskaičiuosime ir įtrauksime)

saldainiu_duomenys = [
    ("Miglė", "Šokoladinis", 6, 2),
    ("Aurora", "Kokosinis", 4, 10),
    ("Rūpintojėlė", "Karamelinis", 3, 15),
    ("Nomeda", "Vaflinis", 3, 5),
    ("Žvaigždutė", "Šokoladinis", 5, 17),
    ("Aukso Lietus", "Karamelinis", 8, 6),
    ("Žiema", "Riešutinis", 7, 12),
    ("Širdelės", "Šokoladinis", 9, 8),
    ("Ugnies Žibintas", "Likerinis", 10, 6),
    ("Karvutė", "Karamelinis", 3, 22)
]



with conn:
    c.executemany("INSERT OR REPLACE INTO Saldainiai(Pavadinimas,Tipas,Perkamas_kiekis,Kaina_kg) VALUES (?, ?, ?, ?)", saldainiu_duomenys)

c.execute("SELECT * FROM Saldainiai")
saldainiai = c.fetchall()
print("Visu saldainiu sarasas: ")
for saldainis in saldainiai:
    print(saldainis)
print()

#3. Užpildykite stulpelį Kaina įtraukdami apskaičiuotas sumos vertes prie atitinkamo saldainio.
with conn:
    c.execute("UPDATE Saldainiai SET Kaina = Kaina_kg * Perkamas_kiekis")
#6. Tarpiniai rezultatai
c.execute("SELECT * FROM Saldainiai")
saldainiai = c.fetchall()
print("Visu saldainiu sarasas(tarpiniai rezultatai): ")
for saldainis in saldainiai:
    print(saldainis)
print()

#4. Atspausdintų tik tuos saldainius kurių tipas "Šokoladinis" ir kaina > 5 eur.
with conn:
    c.execute("SELECT * FROM Saldainiai WHERE Tipas = 'Šokoladinis' AND Kaina > 5")
    sokoladiniai = c.fetchall()
print("Sokoladiniai saldainiai, kuriu kaina didesne nei 5 eurai: ")
for saldainis in sokoladiniai:
    print(saldainis)
print()

#5. Panaikintų input pagalba įvesto saldainio pavadinimimo duomenis - ištrintų visą eilutę lentelėje apie tą saldainį.
panaikinimas = input('Iveskite saldainio pavadinima, kuri norite istrinti: ')
with conn:
    c.execute("DELETE FROM Saldainiai WHERE Pavadinimas = ? ", (panaikinimas,))
#6. Tarpiniai rezultatai
c.execute("SELECT * FROM Saldainiai")
saldainiai = c.fetchall()
print("Sarasas panaikinus saldaini: ")
for saldainis in saldainiai:
    print(saldainis)
print()

#7. Naudodamiesi Seaborn arba Matplotlib Python bibliotekomis, atvaizduokite bent du grafikus (skirtingų tipų - linijinių, stulpelinių, taškinių ar kt. ) Kaina/Saldainis.
# Pakaitaliokite grafikų parametrus, pvz. spalvų paletė. Grafikai turi turėti ašių pavadinimus, vertes ant ašių, pavadinimą. Dar gali turėti legentdą ar kt. pasirinktą info.

from matplotlib import pyplot as plt

conn = sqlite3.connect("duomenu_baze_saldainiai1.db")
c = conn.cursor()
c.execute("SELECT Pavadinimas, Kaina FROM Saldainiai")
saldainiai = c.fetchall()
pavadinimai = [s[0] for s in saldainiai]
kainos = [s[1] for s in saldainiai]

conn.commit()
conn.close()
#grafikas1

plt.figure(1)
plt.bar(pavadinimai, kainos, color = 'green')
plt.xlabel('Saldainis')
plt.ylabel('Kaina')
plt.title('Saldainiu kainos')
plt.xticks(rotation=45)
# plt.show()

#grafikas 2

conn = sqlite3.connect("duomenu_baze_saldainiai1.db")
c = conn.cursor()
c.execute("SELECT Pavadinimas, Kaina FROM Saldainiai WHERE Tipas = 'Šokoladinis'")
sokoladiniai_saldainiai = c.fetchall()
pavadinimai_sokoladiniai = [s[0] for s in sokoladiniai_saldainiai]
kainos_sokoladiniai = [s[1] for s in sokoladiniai_saldainiai]

plt.figure(2)
plt.bar(pavadinimai_sokoladiniai, kainos_sokoladiniai, color='brown')
plt.xlabel('Sokoladiniai saldainiai')
plt.ylabel('Kaina')
plt.title('Sokoladiniu saldainiu kainos')
plt.show()


