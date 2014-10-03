flatten([],[]):-!.

flatten([H|T], Flat):-
    !,
    flatten(H, L1),
    flatten(T, L2),
    append(L1,L2,Flat).

flatten(H, [H]).
