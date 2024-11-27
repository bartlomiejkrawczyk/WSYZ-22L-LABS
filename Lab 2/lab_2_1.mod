var PRODUCTS{1..40, 1..3} >= 0;
var HOURS{1..40, 1..3}, >=0, <=1, integer;


param PROFIT{1..3};
param PER_HOUR{1..3};
param QUANTITY{1..3};


maximize profit_function:
	sum{j in 1..40, i in 1..3} PRODUCTS[j, i] * PROFIT[i];
	
subject to products_constraint{i in 1..3, j in 1..40}:
	PRODUCTS[j, i] <= PER_HOUR[i] * HOURS[j, i];
	
subject to max_quantity_constraint{i in 1..3}:
	sum{j in 1..40}PRODUCTS[j, i] <= QUANTITY[i];
	
subject to only_one_in_hour_constraint{j in 1..40}:
	sum{i in 1..3} HOURS[j, i] <= 1;