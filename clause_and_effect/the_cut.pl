xmax(X,Y,X):-
    X >= Y, !.
xmax(X,Y,Y):-
    X < Y.

drink(milk).
drink(beer) :- !.
drink(gin).

% disjoint partial map with cut
%split(L,P,N), L is a list of numbers, P is positive, N is negative list
split([],[],[]).
split([H|T], [H|Z],R):-
    H >= 0, split(T, Z, R).
split([H|T], R, [H|Z]):-
    H < 0, split(T, R, Z).

% version using cut
% works very efficient, but not best to maintain, each procedure doesn't stand 
% on it's own, especially the last one, must be read with the entire code to
% make sense.
csplit([],[],[]).
csplit([H|T], [H|Z],R):-
    H >= 0, !, csplit(T, Z, R).
csplit([H|T], R, [H|Z]):-
    split(T, R, Z).


% we can use determistic 'if then else' predicate.
esplit(L,P,N):-
    esplit(L,P,N,[],[]).
esplit([],PAcc,NAcc,PAcc,NAcc).
esplit([H|T], P,N,PAcc,NAcc):-
    H >= 0 -> 
        esplit(T, P, N,[H|PAcc],NAcc);
        esplit(T, P, N,PAcc,[H|NAcc]).


