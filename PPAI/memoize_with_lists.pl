% http://www.j-paine.org/prolog/mathnotes/files/pms/node24.html
% Memo-functions with lists

% However, asserting new clauses is rather slow in some Prolog systems. 
% So instead, we can pass the newly-generated results around in a list:

fib( N, F ) :-
    fib( N, F, [ done(0,1), done(1,1) ], _ ).


fib( N, F, L, L ) :-
    member( done(N,F), L ).

fib( N, F, L, [ done(N,F) | L2 ] ) :-
    N1 is N - 1,
    N2 is N - 2,
    fib( N1, F1, L, L1 ),
    fib( N2, F2, L1, L2 ),
    F is F1 + F2.
