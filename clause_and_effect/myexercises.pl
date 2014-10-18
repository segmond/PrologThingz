rotate_list(L,R):-
    rotate_list(L,[],R).

rotate_list([],_,[]).
rotate_list([H|T],Acc,[Res|Z]):-
    append(Acc,[H],L),
    append(T,L,Res),
    rotate_list(T,L,Z).

