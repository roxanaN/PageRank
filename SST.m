function [x] = SST(A, b)
    % Daca matricea nu este superior triunghiulara, sistemul nu se poate rezolva.
    % tril(A, -1) returneaza elementele de sub diagonala principala
    % max(matrix) returneaza un vector ale carui elemente reprezinta
    % suma pe fiecare coloana a matricei.
    % max(list) returneaza maximul din lista

    if max(max(abs(tril(A, -1)))) > 10^3 * eps
        disp('The matrix A is not upper triangular!');
        x = NaN;
        return;
    endif

    n = length(b);
    x = zeros(n, 1);

    % calculam xn
    x(n) = b(n) / A(n, n);

    % calculam x(i)
    for i = (n - 1): -1 : 1
        sum_of_xs = A(i, (i + 1) : n) * x((i + 1) : n, 1);
        x(i) = (b(i) - sum_of_xs) / A(i, i);
    endfor
endfunction
