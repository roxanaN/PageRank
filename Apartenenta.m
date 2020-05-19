% Nume, Prenume, Grupa

function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza
	% valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1

	% Calculam a si b
	a = 1 / (val2 - val1);
	b = - a * val1;
		
	if x < val1
		y = 0;
		return;
	endif

	if x > val2
		y = 1;
		return;
	endif

	if x >= val1 && x <= val2
		y = a * x + b;
		return;
	endif
endfunction