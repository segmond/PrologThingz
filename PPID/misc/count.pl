:- dynamic(count_aux/1).
count(X) :-
    retract(count_aux(N)),
    X is N+1,
    asserta(count_aux(X)).

count_aux(0).
