set ZADANIA;
set RELACJE within (ZADANIA cross ZADANIA);

param NOMINALNY_CZAS {ZADANIA} >= 0;
param KOSZT_SKROCENIA {ZADANIA} >= 0;
param MINIMALNY_CZAS {ZADANIA} >= 0;

param K;


var termin_rozpoczecia_min {ZADANIA} >= 0;
var termin_rozpoczecia_max {ZADANIA} >= 0;
var czas_trwania {ZADANIA} >= 0;

var zapas {ZADANIA} >= 0;

var T_nom >= 0;

var T_min := 0;

var T_k := 0;

minimize czas:
	100 * T_nom - sum{z in ZADANIA} zapas[z];

subject to zapas_czasu {z in ZADANIA}:
	zapas[z] = termin_rozpoczecia_max[z] - termin_rozpoczecia_min[z];
	
subject to kolejnosc_min {(przed, po) in RELACJE}:
	termin_rozpoczecia_min[przed] + czas_trwania[przed] <= termin_rozpoczecia_min[po];

subject to kolejnosc_max {(przed, po) in RELACJE}:
	termin_rozpoczecia_max[przed] + czas_trwania[przed] <= termin_rozpoczecia_max[po];

subject to zakres_czasu_trwania {z in ZADANIA}:
	czas_trwania[z] = NOMINALNY_CZAS[z];
	
subject to koniec_prac_min {z in ZADANIA}:
	termin_rozpoczecia_min[z] + czas_trwania[z] <= T_nom;

subject to koniec_prac_max {z in ZADANIA}:
	termin_rozpoczecia_max[z] + czas_trwania[z] <= T_nom;

