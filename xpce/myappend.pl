myappend([], L, L).

myappend([H|T], L, [H|R]):-
    myappend(T, L, R).
