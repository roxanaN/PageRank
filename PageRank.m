% Nemulescu Roxana-Elena, 312CA
% [USES] Iterative.m
% [USES] Algebraic.m
% [USES] Apartenenta.m

function [R1 R2] = PageRank(nume, d, epsilon)
	% Calculeaza indicii PageRank pentru cele 3 cerinte.

	% Deschidem fisierul de input/
	fid = fopen(nume, 'r');
	% Cream fisierul de output si il deschidem.
	out = strcat(nume, '.out');
    fout = fopen(out, 'w');

    % Citim numarul de pagini web.
	N = fscanf(fid, '%d\n', 1);
	% Citim val1 si val2
	val1 = dlmread(fid, ' ', [N 0 N 1]);
	val2 = dlmread(fid, ' ', [0 0 0 1]);

	% Afisam in fisier numarul de pagini web analizate.
	fprintf(fout, '%d\n\n', N);

	% Afisam in fisier vectorul PR, folosind algoritmul Iterative.
	R1 = Iterative(nume, d, epsilon);
	dlmwrite(fout, R1, '\n', 'precision', 6);
	fprintf(fout, '\n');
	% Afisam in fisier vectorul PR, folosind algoritmul Algebraic.
	R2 = Algebraic(nume, d);
	dlmwrite(fout, R2, '\n', 'precision', 6);
	fprintf(fout, '\n');

	% Matrice formata din indicii paginilor si indicii PageRank.
	% Sortam descrescator, in functie de indicii PageRank.
	% Daca doua pagini au acelasi indice PageRank
	% Se va sorta in functie de numarul paginii.
	PR1 = [[1 : N]', R2];
	PR1 = sortrows(PR1, [-2, -1]);

	% Calculam gradul de apartenenta al fiecarei pagini
	F(1 : N, 1) = PR1(1 : N, 1);
	for i = 1 : N
		F(i, 2) = Apartenenta(PR1(i, 2), val1, val2);
	endfor

	% Numerotam clasamentul si afisam rezultatul in fisier.
	result = [[1 : N]', F];
	dlmwrite(fout, result, ' ', 'precision', 6);

	fclose(fid);
	fclose(fout);
endfunction