% takeout an element from list
takeout(H, [H|T], T).
takeout(H, [X|T], [X|L]):-
    takeout(H,T,L).

perm([X|Y],Z) :-
    perm(Y,W), 
    takeout(X, Z, W).
perm([],[]).


insert_into_list(H,L,R):-
    takeout(H,R,L).
    
% as defined in bratko
% by insert
iperm([],[]).
iperm([H|T],P):-
    iperm(T,PT),
    insert_into_list(H,PT,P).

% by delete
dperm([],[]).
dperm(L, [H|T]):-
    takeout(H,L,PL),
    dperm(PL,T).
