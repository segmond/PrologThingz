% lists
list([]).
list([X|Xs]):-
    list(Xs).

member(X, [X|Xs]):-
    list(Xs).

member(X, [Y|Ys]):-
    member(X, Ys).


prefix([], Ys).

prefix([X|Xs], [X|Ys]):-
    prefix(Xs, Ys).


suffix(Xs, Xs).

suffix(Xs, [Y|Ys]):-
    suffix(Xs, Ys).


sublist(Xs, Xs).

sublist(Xs, [Y|Ys]):-
    prefix(Xs, Ys).

sublist(Xs, [Y|Ys]):-
    sublist(Xs, Ys).

mydelete([], X, []).

mydelete([X|Xs], X, Ys):-
    mydelete(Xs, X, Ys).

mydelete([Y|Xs], X, [Y|Ys]):-
    mydelete(Xs, X, Ys).
