% Nemulescu Roxana-Elena, 312CA
% [USES] SST

function A_inv = GramSchmidt(A)
	% Functia care calculeaza inversa matricei A
	% folosind factorizari Gram-Schmidt
	
    [m n] = size(A);
    Q = A;
    R = zeros(m,n);

    % Iteram prin fiecare coloana, pentru a afla matricea ortogonala Q
    % Aflam matricea superior triunghiulara R
    for k = 1 : n
        R(k, k) = norm(Q(1 : m, k));
        Q(1 : m, k) = Q(1 : m, k) / R(k, k);

        for j = k + 1 : n
            R(k, j) = Q(1 : m, k)' * Q(1 : m, j);
            Q(1 : m, j) = Q(1 : m, j) - Q(1 : m, k) * R(k, j);
        endfor
    endfor

    % Calculam inversa matricei A,
    % rezolvand n sisteme superior triunghiulare
    A_inv = zeros(n);
    I = eye(n);
    for j = 1 : n
        A_inv(1 : n, j) = SST(R, Q' * I(1 : n, j));
    endfor
endfunction
