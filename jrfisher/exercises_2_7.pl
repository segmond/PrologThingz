% takeout an element from list
takeout(H, [H|T], T).
takeout(H, [X|T], [X|L]):-
    takeout(H,T,L).

perm([X|Y],Z) :-
    perm(Y,W), 
    takeout(X, Z, W).
perm([],[]).

subset([],_).
subset([X|R],S):-
    member(X,S),
    subset(R,S).

union([],R,R).
union([H|T],L,[H|R]):-
    \+ member(H,L),
    union(T,L,R).
union([H|T],L,R):-
    member(H,L),
    union(T,L,R).

intersection([],_,[]).
intersection([H|T],L,[H|R]):-
    member(H,L),
    intersection(T,L,R).

intersection([H|T],L,R):-
    \+ member(H,L),
    intersection(T,L,R).


% delete E from List and return the result in R
%delete(E,L,R)
delete_from_list(_,[],[]).
delete_from_list(E,[E|T],R):-
    delete_from_list(E,T,R).
delete_from_list(E,[H|T],[H|R]):-
    delete_from_list(E,T,R).
    
% remove all duplicates in A and return the result in B
prune([H|T],[H|X1]):-
    delete_from_list(H,T,X), 
    prune(X,X1).
prune([],[]).

% prefix(A,B), sees if A is a list prefix of B
prefix([],_).
prefix([H|T],[H|Y]):-
    prefix(T,Y).
    
% segment(A,B), tests if A is contained anywhere in B
segment([],_).
segment(A,B):-
    prefix(A,B).
segment(A,[H|T]):-
    prefix(A,T).
segment(A,[H|T]):-
    segment(A,T).
