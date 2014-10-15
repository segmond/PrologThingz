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

% prefix
gprefix([],_).
gprefix([H|T],[H|Y]):-
    gprefix(T,Y).

% use prefix
gsublist(S,L):-
    gprefix(S,L).
gsublist(S,[H|T]):-
    gsublist(S,T).
    
% book definition
sublist(S,L):-
    append(L1,L2,L),
    append(S,L3,L2).

evenlength([]).
evenlength([A,B|T]):-
    evenlength(T).

oddlength([H|T]):-
    evenlength(T).
