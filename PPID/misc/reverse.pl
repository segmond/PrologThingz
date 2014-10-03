reverse([],[]).

reverse([H|T], R):-
    reverse(T, RT),
    append(RT,[H],R).

fast_reverse(L,R):-
    nonvar(L),
    fast_reverse_aux(L,[],R).

fast_reverse_aux([H|T],Stack,R):-
    fast_reverse_aux(T,[H|Stack],R).

fast_reverse_aux([],R,R).
