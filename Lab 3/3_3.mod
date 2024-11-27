set BLOKI;
set PRACE;
set DODATKI;
set KOLEJNOSC within (BLOKI cross BLOKI);
set KOLEJNOSC_PRAC within (PRACE cross PRACE);

param CZASY_PRACY {PRACE, BLOKI} >= 0;
param CZASY_PRACY_DODATKI {DODATKI} >= 0;

param WYLEWKA;
param WYKONCZENIE;

var czas_startu_pracy {BLOKI, PRACE} >= 0 integer;

var czas_startu_dodatki {DODATKI} >= 0 integer;

var czas;

maximize start_prac: 
	sum{b in BLOKI, p in PRACE} czas_startu_pracy[b, p] 
	+ sum{d in DODATKI} czas_startu_dodatki[d] 
	- 100 * czas;

subject to ograniczenie_czasu_1{d in DODATKI}:
	czas >= czas_startu_dodatki[d] + CZASY_PRACY_DODATKI[d] + WYKONCZENIE;

subject to ograniczenie_czasu_2{b in BLOKI}:
	czas >= czas_startu_pracy[b, 'Wykonczenie'] + CZASY_PRACY['Wykonczenie', b]  + WYKONCZENIE;

subject to ograniczenie_czasu_dodatki{d in DODATKI, b in BLOKI}:
	czas_startu_dodatki[d] >= czas_startu_pracy[b, 'Okna'];

subject to poczatek_po_wylewkach {b in BLOKI, p in PRACE}:
	czas_startu_pracy[b, p] >= WYLEWKA;

subject to poczatek_po_koncu_poprzedniego {b in BLOKI, (p1, p2) in KOLEJNOSC_PRAC}:
	czas_startu_pracy[b, p1] + CZASY_PRACY[p1, b] <= czas_startu_pracy[b, p2];

subject to zachowaj_kolejnosc {(p,k) in KOLEJNOSC}:
	czas_startu_pracy[p, 'Dach'] + CZASY_PRACY['Dach', p] <= czas_startu_pracy[k, 'Sciany'];
	
	