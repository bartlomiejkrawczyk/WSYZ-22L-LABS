set BLOKI;
set ZADANIA;
set RELACJE within (BLOKI cross BLOKI);
set ZADANIA_RELACJE within (ZADANIA cross ZADANIA);

param CZAS_FUNDAMENTY;

param NOMINALNY_CZAS {BLOKI, ZADANIA} >= 0;
param MINIMALNY_CZAS {BLOKI, ZADANIA} >= 0;
param PRACOWNICY {BLOKI, ZADANIA} >= 0;

set WYKANCZANIE;

param NOMINALNY_CZAS_WYK {WYKANCZANIE} >= 0;
param MINIMALNY_CZAS_WYK {WYKANCZANIE} >= 0;
param PRACOWNICY_WYK {WYKANCZANIE} >= 0;

param CZAS_OSTATNIE_PRACE;
param WYNAGRODZENIE;
param K;


var termin_rozpoczecia_min {BLOKI, ZADANIA} >= CZAS_FUNDAMENTY;
var termin_rozpoczecia_max {BLOKI, ZADANIA} >= CZAS_FUNDAMENTY;
var czas_trwania {BLOKI, ZADANIA} >= 0;

var zapas {BLOKI, ZADANIA} >= 0;

var termin_rozpoczecia_min_wyk {WYKANCZANIE} >= 0;
var termin_rozpoczecia_max_wyk {WYKANCZANIE} >= 0;

var czas_trwania_wyk {WYKANCZANIE} >= 0;

var zapas_wyk {WYKANCZANIE} >= 0;

var T_nom >= 0;

minimize czas:
	100 * T_nom - sum{b in BLOKI, z in ZADANIA} zapas[b, z] - sum{w in WYKANCZANIE} zapas_wyk[w];

subject to zapas_czasu {b in BLOKI, z in ZADANIA}:
	zapas[b, z] = termin_rozpoczecia_max[b, z] - termin_rozpoczecia_min[b, z];
	
subject to kolejnosc_min {(przed, po) in RELACJE}:
	termin_rozpoczecia_min[przed, 'Dach'] + czas_trwania[przed, 'Dach'] <= termin_rozpoczecia_min[po, 'Dach'];

subject to kolejnosc_max {(przed, po) in RELACJE}:
	termin_rozpoczecia_max[przed, 'Dach'] + czas_trwania[przed, 'Dach'] <= termin_rozpoczecia_max[po, 'Dach'];

subject to zakres_czasu_trwania {b in BLOKI, z in ZADANIA}:
	czas_trwania[b, z] = NOMINALNY_CZAS[b, z];
	
subject to koniec_prac_min {b in BLOKI, z in ZADANIA}:
	termin_rozpoczecia_min[b, z] + czas_trwania[b, z] + CZAS_OSTATNIE_PRACE <= T_nom;

subject to koniec_prac_max {b in BLOKI, z in ZADANIA}:
	termin_rozpoczecia_max[b, z] + czas_trwania[b, z] + CZAS_OSTATNIE_PRACE <= T_nom;

subject to koniec_prac_min_wyk {w in WYKANCZANIE}:
	termin_rozpoczecia_min_wyk[w] + czas_trwania_wyk[w] + CZAS_OSTATNIE_PRACE <= T_nom;

subject to koniec_prac_max_wyk {w in WYKANCZANIE}:
	termin_rozpoczecia_max_wyk[w] + czas_trwania_wyk[w] + CZAS_OSTATNIE_PRACE <= T_nom;

subject to zakres_czasu_trwania_wyk {w in WYKANCZANIE}:
	czas_trwania_wyk[w] = NOMINALNY_CZAS_WYK[w];

