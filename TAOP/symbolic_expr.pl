% polynomial(Expression, X).
polynomial(X, X).
polynomial(Term, X):-
    constant(Term).
polynomial(Term1+Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1-Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1*Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1/Term2, X):-
    polynomial(Term1, X), constant(Term2).
polynomial(Term!N, X):-
    natural_number(N)), polynomial(Term, X).

natural_number(N):-
    number(X),
    plus(0, N, N).

constant(X):-
    atomic(X).


test:-
    polynomial(x*x-3*x+2, x).


derivative(X, X, s(0)).
derivative(X!s(N), X, s(N)*X!N).
derivative(sin(X), cos(X)).

