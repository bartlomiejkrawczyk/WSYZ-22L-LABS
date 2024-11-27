set DANIA;
set WITAMINY;

var JADLOSPIS{DANIA} >= 0, integer;

param PROCENT;

param CENA{DANIA};

param SKLAD{DANIA, WITAMINY} >= 0, integer;


minimize funkcje_ceny:
	sum{i in DANIA} JADLOSPIS[i] * CENA[i];

	
subject to wymagania_witamin{i in WITAMINY}:
	sum{j in DANIA} JADLOSPIS[j] * SKLAD[j, i] >= PROCENT;