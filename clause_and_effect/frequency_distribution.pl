% worksheet 23

freq(L,S):-
    freq(L,[],S).
freq([],S,S).
freq([N|L],S1,Res):-
    update(N,S1,S2), % output list modified using the update predicate
    freq(L,S2,Res).

% update(Key, BeforeList, AfterList 
update(N, [], [1*N]).
update(N, [F*N|S], [F1*N|S]):-
    !,
    F1 is F+1.
update(N, [F*M|S], [1*N,F*M|S]):-
    N < M, 
    !.
update(N, [F*M|S], [F*M|S1]):-
    N \== M,
    update(N,S,S1).

