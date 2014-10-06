% takeout an element from list
takeout(H, [H|T], T).
takeout(H, [X|T], [X|L]):-
    takeout(H,T,L).
