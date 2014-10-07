member(E, [E|_]).
member(E, [_|T]):-
    member(E, T).

mystery(X,A,B) :-
    member(X,A),
    member(X,B).

coeff(A,_,B,Y) :-
    Y is A * B + B.

llength([], 0).

llength([_|T], R) :-
    llength(T, R1),
    R is R1 + 1.

% tail recursive length
tr_length([], 0).
tr_length(L, R) :-
    accumulate(L, 0, R).

accumulate([], Acc, Acc).
accumulate([_|T], Acc, R):-
    NewAcc is Acc + 1,
    accumulate(T, NewAcc, R).

sum([], 0).
sum([H|T], N) :-
    sum(T, N1),
    N is H+N1.
    
% inner product, naive version
inner([], [], 0).
inner([H1|TVecA], [H2|TVecB], DotProduct):-
    inner(TVecA, TVecB, NDotProduct),
    DotProduct is NDotProduct + (H1 * H2).

% inner accumlate
tr_inner(V1, V2, DP):-
    tr_inner(V1,V2,0,DP).

tr_inner([],[],Acc,Acc).
tr_inner([H1|TVecA], [H2|TVecB], Acc, DotProduct):-
    NewAcc is Acc  + (H1 * H2),
    tr_inner(TVecA, TVecB, NewAcc, DotProduct).
