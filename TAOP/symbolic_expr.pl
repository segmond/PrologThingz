% polynomial(Expression, X).
polynomial(X, X).
polynomial(Term, _):-
    constant(Term).
polynomial(Term1+Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1-Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1*Term2, X):-
    polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1/Term2, X):-
    polynomial(Term1, X), constant(Term2).
polynomial(Term^N, X):-
    natural_number(N), polynomial(Term, X).

natural_number(N):-
    number(N),
    plus(0, N, N).

constant(X):-
    atomic(X).


test:-
    polynomial(x*x-3*x+2, x).


derivative(X, X, s(0)).
derivative(X^s(N), X, s(N)*X^N).
derivative(sin(X), X, cos(X)).
derivative(cos(X), X, -sin(X)).
derivative(e^X, X, e^X).
derivative(log(X), X, 1/X).

derivative(F+G, X, DF+DG):-
    derivative(F, X, DF),
    derivative(G, X, DG).
derivative(F-G, X, DF-DG):-
    derivative(F, X, DF),
    derivative(G, X, DG).
derivative(F*G, X, F*DG+DF*G):-
    derivative(F, X, DF),
    derivative(G, X, DG).
derivative(1/F, X, -DF/(F*F)):-
    derivative(F, X, DF).
derivative(F/G, X, (G*DF-F*DG)/(G*G)):-
    derivative(F, X, DF),
    derivative(G, X, DG).
derivative(U^s(N), X, s(N)*U^N*DU):-
    derivative(U, X, DU).
derivative(unary_term(F, U), X, DF*DU):-
    derivative(unary_term(F, U), U, DF),
    derivative(U, X, DU).


