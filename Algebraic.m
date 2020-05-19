% Nemulescu Roxana-Elena, 312CA
% [USES] GramSchmidt.m

function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank, folosind varianta algebrica.
	% Intrari:
	% -> nume: numele fisierului din care se citeste;
	% -> d: probabilitatea ca, un anumit utilizator, sa continue navigarea,
	% la o pagina urmatoare.
	% Iesiri:
	% -> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

	% Deschim fisierul
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
	neighbors = list( : , 3: N);

	% Formam matricea de adiacenta.
	A = zeros(N);
	for i = 1 : N
		for j = 1 : nr_neighbors(i)
			k = neighbors(i, 1 : nr_neighbors(i));
			A(i, k) = 1;
		endfor
		
		% Verificam daca pagina are link catre ea insasi
		if A(i, i)
			A(i, i) = 0;
			nr_neighbors(i)--;
		endif
	endfor

	% Determinam indicii PageRank.
	[n, m] = size(A);
	R = zeros(N, 1);
	M = zeros(n, m);

	% Formam matricea M:
	for j = 1 : m
		for i = 1 : n
			if A(j, i)
				M(i, j) = 1 / nr_neighbors(j);
			endif
		endfor
	endfor

	% Aflam (I - d * M)^(-1)
	I = eye(N);
	T = (I - d * M);
	T_inv = GramSchmidt(T);

	% Calculam indicii PageRank
    v1(1 : n, 1) = 1;
	R =  T_inv * ((1 - d) / N) * v1;

	fclose(fid);
endfunction