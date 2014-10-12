% takeout an element from list
takeout(H, [H|T], T).
takeout(H, [X|T], [X|L]):-
    takeout(H,T,L).

perm([X|Y],Z) :-
    perm(Y,W), 
    takeout(X, Z, W).
perm([],[]).
