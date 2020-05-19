% Nemulescu Roxana-Elena, 312CA

function R = Iterative(nume, d, epsilon)
	% Functie carecalculeaza matricea R folosind algoritmul iterativ.
	%Intrari:
	% -> nume: numele fisierului din care se citeste;
	% -? d: coeficientul d, adica probabilitatea ca un anumit navigator sa
	% continue navigarea (0.85 in cele mai bune cazuri)
	% -> epsilon: eroarea care apare in algoritm
	% Iesiri:
	% -> R: vectorul de PageRank-uri acordat pentru fiecare pagina

	% Deschidem fisierul
	fid = fopen(nume, 'r');
	
	% Citim numarul de pagini web
	N = fscanf(fid, '%d\n', 1);
	% Citim urmatoarele N linii din fisier, in matricea list.
	% Formam lista de adiacenta si retinem val1 si val2.
	list = dlmread(fid, ' ', [0 0 (N - 1) (N - 1)]);

	% Interpretam lista de vecini.
	% Retinem nodurile, numarul de vecini si vecinii fiecarui nod
	vertices = (list( : , 1))';
	nr_neighbors = (list( : , 2))';
	neighbors = list( : , 3 : N);

	A = zeros(N);
	for i = 1 : N
		for j = 1 : nr_neighbors(i)
			k = neighbors(i, 1 : nr_neighbors(i));
			A(i, k) = 1;
		endfor

		% Verificam daca pagina are link spre ea insasi
		if A(i, i)
			A(i, i) = 0;
			nr_neighbors(i)--;
		endif
	endfor

	% Formam matricea M:
	[n, m] = size(A);
	M = zeros(n, m);
	for j = 1 : m
		for i = 1 : n
			if A(j, i)
				M(i, j) = 1 / nr_neighbors(j);
			endif
		endfor
	endfor

	% Calculam indicii PageRank, folosind forma matriceala
	v1(1 : n, 1) = 1;
	R(1 : N, 1) = 1 / N;
	R0 = zeros(N, 1);
	while (1)
		if norm(R(1 : N, 1) - R0(1 : N, 1)) < epsilon
			break;
		endif

		R0 = R;
		R(1 : n, 1) = ((1 - d) / N) * v1  + d * M * R0(1 : n, 1);
	endwhile
	R = R0;

	fclose(fid);
endfunction
