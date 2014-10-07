member(E, [E|T]).
member(E, [H|T]):-
    member(E, T).

mystery(X,A,B) :-
    member(X,A),
    member(X,B).

coeff(A,X,B,Y) :-
    Y is A * B + B.

llength([], 0).

llength([H|T], R) :-
    llength(T, R1),
    R is R1 + 1.

% tail recursive length
tr_length([], 0).
tr_length(L, R) :-
    accumulate(L, 0, R).

accumulate([], Acc, Acc).
accumulate([H|T], Acc, R):-
    NewAcc is Acc + 1,
    accumulate(T, NewAcc, R).

sum([], 0).
sum([H|T], N) :-
    sum(T, N1),
    N is H+N1.
    
