:-op(700, xfx, iss).
:-op(150, xf, !).

fact(1, 1):-
    !.

fact(N, Y):-
    N1 is N - 1,
    fact(N1, Y1),
    Y is N * Y1.

Y iss X:-
    Y is X, !.

/* this is broken */
Y iss N!:-
    writeln(N),
    N1 iss N,
    fact(N1, Y),
    !.

foo(Y, !(N)):-
    writeln(N),
    N1 iss N,
    fact(N1, Y),
    !.



% logic programming with prolog
% practical exercise 11.2
addArg(Predicate, Term, Res):-
    Predicate =.. Terms,
    append(Terms, [Term], NewTerms),
    Res =.. NewTerms.
