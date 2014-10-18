% rotate a list
rotall([],A,[]).
rotall([H|T],A,[L|Z]):-
    append([H|T],A,L),
    append(A,[H],A1),
    rotall(T,A1,Z).
