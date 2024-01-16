# Turite duomenis apie UAB „Autoparkas“ priklausančius automobilius.
# Duomenų faile (txt ar csv) pateikta ši informacija: valstybinis numeris, gamintojas, modelis, pagaminimo metai.
#
# 1. Raskite, kurių gamintojų automobilių yra daugiau nei vienas, ekrane atspausdinkite gamintojų pavadinimus. (Atspausdinkite ir kiekį - NEBŪTINA)
# 2. Sudarykite visų pasirinkto gamintojo (pvz.: „Volvo“) automobilių sąrašą, ekrane atspausdinkite automobilio valstybinį numerį, modelį, bei pagaminimo metus. Jei tokio automobilio sąraše nėra atspausdinkite pranešimą - "Tokio gamintojo automobilių sąraše nėra".
# 3. Sudarykite sąrašą, senesnių nei 10 metų, į failą „Senienos.csv“ surašykite visus jų duomenis.
#
# Jei senienų programa neranda atspausdinkite pranešimą į failą - "Senesnių nei 10 metų automobilių sąraše nėra".
#
#
# Reikalavimai: Naudoti sąrašus,failų skaitymą ir rašymą, funkcijas.

# 2
def atrinkti_automobili_pagal_gamintoja(autoparkas, gamintojas):
    atrinkti = []
    for automobilis in autoparkas:
        if automobilis['gamintojas'] == gamintojas:
            atrinkti.append(automobilis)
    return atrinkti

def atrinktu_automobiliu_isvedimas(atrinkti, gamintojas):
    rezultatas = ''
    if len(atrinkti) != 0:
        print(f'Automobiliai pagal pasirinkta gamintoja: ')
        for automobilis in atrinkti:
            print(
                f'Automobilio valstybiniai numeriai - {automobilis['valstybiniai_numeriai']}, gamintojas -  {automobilis['gamintojas']}, metai - {automobilis['metai']}')
    else:
        print(f'Gamintojo {gamintojas} automobiliu sarase nera.')
    return rezultatas

autoparkas = []
gamintojas = 'Volvo'

with open('autoparkas.txt', encoding="utf8") as failas:
    for eilute in failas:
        eilute = eilute.rstrip('\n')
        isskaidyta = eilute.split(',')
        automobilis = dict(
            valstybiniai_numeriai = isskaidyta[0],
            gamintojas = isskaidyta[1],
            modelis = isskaidyta[2],
            metai = int(isskaidyta[3])
        )
        autoparkas.append(automobilis)

atrinkti = atrinkti_automobili_pagal_gamintoja(autoparkas, gamintojas)
rezultatas = atrinktu_automobiliu_isvedimas(atrinkti, gamintojas)
print(rezultatas)

#1

gamintojai = [auto['gamintojas'] for auto in autoparkas]
pasikartojantys = set([gamintojas for gamintojas in gamintojai if gamintojai.count(gamintojas) > 1])

print('Gamintojai, kuriu automobiliu yra daugiau nei vienas: ')
for gamintojas in pasikartojantys:
    print(gamintojas)
print()

gamintoju_skaicius = {}
for gamintojas in gamintojai:
    gamintoju_skaicius[gamintojas] = gamintoju_skaicius.get(gamintojas, 0) + 1

print("Gamintojų pasikartojimai:")
for gamintojas, kiekis in gamintoju_skaicius.items():
     print(f"{gamintojas}: {kiekis} kartai")
print()


# 3

from datetime import datetime
from csv import writer

dabar = datetime.now().year
senienos = [automobilis for automobilis in autoparkas if dabar - automobilis['metai'] > 10]


if len(senienos) != 0:
    with open("Senienos.csv", mode='w', newline='') as file_write:
        csv_writer = writer(file_write)
        csv_writer.writerow(['Numeriai', 'gamintojas', 'modelis', 'metai'])
        for automobilis in senienos:
            csv_writer.writerow(list(automobilis.values()))
else:
    with open('Senienos.csv', mode='w', newline='') as file_write:
        csv_writer = writer(file_write)
        csv_writer.writerow(['Senesniu nei 10 metu automobiliu sarase nera.'])



