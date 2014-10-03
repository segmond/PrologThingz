close_enough(X,X):- !.

close_enough(X,Y):-
    X < Y,
    Y-X < 0.0001.

close_enough(X,Y):-
    X > Y,
    close_enough(Y,X).
