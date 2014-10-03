close_enough(X,X):- !.

close_enough(X,Y):-
    X < Y,
    Y-X < 0.0001.

close_enough(X,Y):-
    X > Y,
    close_enough(Y,X).

real_square_root(X, nonexistence) :-
    nonvar(X),
    X < 0.0.

% removes the spurious nondeterminism to ensure real_square_root(1.21, 1.1) returns once
real_square_root(X, Y):-
    nonvar(X),
    nonvar(Y),
    Y is sqrt(X),
    !.

real_square_root(X, Y):-
    nonvar(X),
    X >= 0.0,
    R is sqrt(X),
    close_enough(R, Y).

real_square_root(X, Y):-
    nonvar(X),
    X >= 0.0,
    R is -sqrt(X),
    close_enough(R, Y).

real_square_root(X, Y):-
    nonvar(Y),
    Ysquared is Y*Y,
    close_enough(Ysquared, X).
