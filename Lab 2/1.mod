set WKRETY;
set MASZYNY;

param zamowienia{WKRETY} >= 0, integer;
param czas_wytworzenia{MASZYNY, WKRETY} >=0;
param ilosc_energii{MASZYNY} >= 0, integer;

var produkcja_wkretow{i in MASZYNY, j in WKRETY} >= 0, integer;

var czasy{i in MASZYNY} = sum{j in WKRETY} czas_wytworzenia[i, j] * produkcja_wkretow[i, j];

var maksimum;

# minimize zuzycie_energii: sum{j in WKRETY, i in MASZYNY} ilosc_energii[i] * produkcja_wkretow[i, j];

# minimize czasy_maszyn: sum{i in MASZYNY} czasy[i];


# subject to czas_najwolniejszej{i in MASZYNY}:czasy[i] <= maksimum; 
# minimize czas: maksimum;

var odchylka{MASZYNY, 1..2} >= 0;

minimize abc: sum{i in MASZYNY, j in 1..2} odchylka[i, j];

subject to abcde{i in MASZYNY}: odchylka[i, 1] - odchylka[i, 2] + czasy[i] = 500;

subject to wyprodukowane {j in WKRETY}: sum{i in MASZYNY} produkcja_wkretow[i, j] = zamowienia[j];
subject to czas_maszyn {i in MASZYNY}: sum{j in WKRETY} produkcja_wkretow[i, j] * czas_wytworzenia[i, j] >= 10;