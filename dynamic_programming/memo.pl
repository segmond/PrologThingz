:- dynamic stored/1.
memo(Goal) :- ( stored(Goal) -> true ; Goal, assertz(stored(Goal)) ).

% tail recursive
fib(0, A, _, A).
fib(N, A, B, F) :- 
    N1 is N - 1, 
    Sum is A + B, 
    fib(N1, B, Sum, F).

fib(N, F) :- 
    fib(N, 0, 1, F).

% Naive
fibN(0, 0):- !.
fibN(1, 1):- !.
fibN(N, NF) :-
    A is N - 1, B is N - 2,
    fibN(A, AF), fibN(B, BF),
    NF is AF + BF.

% Memoized
% faster than naive, but slower than tail recursive as values get larger
fibM(0, 0).
fibM(1, 1).
fibM(N, NF):-
    stored(fibM(N, NF)).
fibM(N, NF) :-
    A is N - 1, B is N - 2,
    memo(fibM(A, AF)), memo(fibM(B, BF)),
    NF is AF + BF.
