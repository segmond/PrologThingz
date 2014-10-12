% ex 3.1
% delete last N elements off L
del_lastN(L,N,X):-
    length(Y,N),
    append(X,Y,L).

% ex 3.2
% add to end of list
last(E, [], [E]).
last(E,[H|T], [H|X]):-
    last(E,T,X).

% broken
xsublist([],_).
xsublist([A|B],[H|T]):-
    xsublist([A|B],T).
xsublist([H|B],[H|T]):-
    xsublist(B,T).

sublist(S,L):-
    append(L1,L2,L),
    append(S,L3,L2).
    

