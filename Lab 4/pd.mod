set ZADANIA;
set RELACJE within (ZADANIA cross ZADANIA);

param NOMINALNY_CZAS {ZADANIA} >= 0;
param KOSZT_SKROCENIA {ZADANIA} >= 0;
param MINIMALNY_CZAS {ZADANIA} >= 0;

param K;


var termin_rozpoczecia_min {ZADANIA} >= 0;
var termin_rozpoczecia_max {ZADANIA} >= 0;
var czas_trwania {ZADANIA} >= 0;

var skrocony_czas {ZADANIA} >= 0;

var zapas {ZADANIA} >= 0;

var jednostek {ZADANIA} >= 0;

#b var T_nom >= 0;
param T_nom = 0;


#c var T_min >= 0;
param T_min = 0;

var T_k >= 0;

minimize czas:
#b	100 * T_nom - sum{z in ZADANIA} zapas[z];
#c	100 * T_min - sum{z in ZADANIA} zapas[z];
	100 * T_k - sum{z in ZADANIA} zapas[z];

subject to zapas_czasu {z in ZADANIA}:
	zapas[z] = termin_rozpoczecia_max[z] - termin_rozpoczecia_min[z];
	
subject to kolejnosc_min {(przed, po) in RELACJE}:
	termin_rozpoczecia_min[przed] + czas_trwania[przed] <= termin_rozpoczecia_min[po];

subject to kolejnosc_max {(przed, po) in RELACJE}:
	termin_rozpoczecia_max[przed] + czas_trwania[przed] <= termin_rozpoczecia_max[po];

subject to zakres_czasu_trwania {z in ZADANIA}:
#b	czas_trwania[z] = NOMINALNY_CZAS[z];
#c	czas_trwania[z] = MINIMALNY_CZAS[z];
	czas_trwania[z] = NOMINALNY_CZAS[z] - skrocony_czas[z];

#d
subject to min_czas_trwania {z in ZADANIA}:
	MINIMALNY_CZAS[z] <= czas_trwania[z];

#d
subject to max_czas_trwania {z in ZADANIA}:
	czas_trwania[z] <= NOMINALNY_CZAS[z];
	
subject to koniec_prac_min {z in ZADANIA}:
#b	termin_rozpoczecia_min[z] + czas_trwania[z] <= T_nom;
#c	termin_rozpoczecia_min[z] + czas_trwania[z] <= T_min;
	termin_rozpoczecia_min[z] + czas_trwania[z] <= T_k;

subject to koniec_prac_max {z in ZADANIA}:
#b	termin_rozpoczecia_max[z] + czas_trwania[z] <= T_nom;
#c	termin_rozpoczecia_max[z] + czas_trwania[z] <= T_min;
	termin_rozpoczecia_max[z] + czas_trwania[z] <= T_k;

#d
subject to przydzielonych_jednostek {z in ZADANIA}:
 	jednostek[z] = skrocony_czas[z] * KOSZT_SKROCENIA[z];
 
#d
subject to suma_zasobow:
	sum{z in ZADANIA} jednostek[z] <= K;

