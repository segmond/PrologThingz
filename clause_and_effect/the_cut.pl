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


% set difference
% sd(A,B,C) succeeds when set C is the result of subtract set B from set A
sd([],_,[]).
sd([E|S1],S2,S3):-
    member(E,S2),
    !,
    sd(S1,S2,S3).
sd([E|S1],S2,[E|S3]):-
    sd(S1,S2,S3).

% cut and negation as failure

% john likes any food except beef
food(beans).
food(rice).
likes(john, X) :- food(beef), !, fail.
likes(john, X) :- food(X).

% different
different(X,X) :- !, fail.
different(X,Y).

my_not(G):-
    call(G), !, fail.
my_not(_).

% negation as failure can be misleading
occupation(seg, programmer).
innocent(peter_pan).
innocent(X):-
    occupation(X,nun).
innocent(winn_the_pooh).
innocent(julie_andrews).
guilty(X):-
    occupation(X,thief).
guilty(joe_bloggs).

guilty(X):- % this is flawed
    \+(innocent(X)).
% guilty(st_francis).


% negation as failure just is problematic, just fail
good_hotel(goedels).
good_hotel(freges).
good_hotel(schoenfinkels).
good_hotel(wittgensteins).
expensive_hotel(goedels).
expensive_hotel(wittgensteins).
reasonable(R):-
    not(expensive_hotel(R)).

%good_hotel(X), reasonable(X) doesn't give same answer as reasonable(X), good_hotel(X).
