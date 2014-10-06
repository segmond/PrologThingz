border(sussex, kent).
border(sussex, surrey).
border(surrey, kent).
border(hampshire, sussex).
border(hampshire, surrey).
border(hampshire, berkshire).
border(berkshire, surrey).
border(wiltshire, hampshire).
border(wiltshire, berkshire).

adjacent(X,Y) :-
    border(X,Y).
adjacent(X,Y) :-
    border(Y,X).

affordable(X,Z) :-
    adjacent(X,Y),
    adjacent(Y,Z).
