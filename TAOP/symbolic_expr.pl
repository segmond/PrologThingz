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
