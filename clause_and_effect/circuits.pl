% circuits

% invert
inv(0,1).
inv(1,0).

% nand
nand(0,0,1).
nand(0,1,1).
nand(1,0,1).
nand(1,1,0).

%or
or(0,0,0).
or(1,0,1).
or(0,1,1).
or(1,1,1).

% and
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

% xor
xor(0,0,0).
xor(0,1,1).
xor(1,0,1).
xor(1,1,0).

% nor
nor(0,0,1).
nor(1,0,0).
nor(0,1,0).
nor(1,1,0).

% example
c1(A,B,C,D,E):-
    nand(A,B,T1),
    nor(C,D,T2),
    nand(T1,T2,E).

c2(A,B,C):-
    nand(A,B,T1),
    xor(A,T1,T2),
    inv(T2,C).

c3(A,B,D):-
    nand(A,B,T1),
    nand(A,T1,T2),
    nand(B,T1, T3),
    nand(T2,T3,D).

% half subtracter
half_sub(I1,I2,D,BO):-
    xor(I1,I2,D),
    inv(I1,T1),
    and(I2,T1,BO).

% full subtracter
full_sub(I1,I2,BI,D,BO):-
    xor(I1,I2,T1),
    xor(T1,BI,D),
    inv(T1,T2),
    inv(I1,T3),
    nand(T2,BI,T4),
    nand(T3,I2,T5),
    nand(T4,T5,BO).

% 3bit subtractor
three_sub(A0,A1,A2,B0,B1,B2, D0,D1,D2,T2):-
    half_sub(A0,B0,D0,T0),
    full_sub(A1,B1,T0,D1,T1),
    full_sub(A2,B2,T1,D2,T2).


% convert an expression X into a DeMorganized form Y
%   in which the scope of negations has been minimized.
dm(0, 0).

dm(1, 1).

dm(-(-A), B):-
    dm(A, B).

dm(-(A+B), U*V):-
    dm(-A, U), 
    dm(-B, V).

dm(-(A*B), U+V):-
    dm(-A, U), 
    dm(-B, V).

dm(A+B, U+V):-
    dm(A, U), 
    dm(B, V).

dm(A*B, U*V):-
    dm(A, U), 
    dm(B, V).

dm(-A, -(A)).
dm(X, X).

test_dm(L,X):-
    L = -(a*b)+a*(-(b+c)),
    dm(L,X).


% convert the demorganized form into (sums of product) SOP standard form
sop(P*Q, R):-
    sop(P, P1),
    sop(Q, Q1),
    dist(P1*Q1, R).

sop(P+Q, P1+Q1):-
    sop(P, P1),
    sop(Q, Q1).

sop(X, X).

dist((P+Q)*R, P1+Q1):-
    sop(P*R, P1),
    sop(Q*R, Q1).

dist(P*(Q+R), Q1+R1 ):-
    sop(P*Q, Q1),
    sop(P*R, R1).

dist(P, P).

test_sop(L,A,B):-
    L = (a+b)*(-a+b),
    dm(L,A),
    sop(A,B).

% we can convert SOP expression a*b+(-a)*c+b*c into [[a,b], [-a,c], [b,c]].
% to do so, we flatten the sum tree into a list, and gather up the products into a list which they are found
flat(A+(B+C),U):-
    !,
    flat((A+B)+C,U).

flat(A+B, L1-L3):-
    !,
    flat(A,L1-L2),
    flat(B,L2-L3).

flat(A, [B|Q]-Q):-
    setfactors(A, [], B).

setfactors(A*B, Acc, L):-
    !,
    setfactors(A, Acc, A1),
    setfactors(B, A1, L).

setfactors(A, L, [A|L]):-
    %notin(A,L),
    \+ member(A,L),
    !.

setfactors(A, L, L).

test_flat(L,F):-
    test_sop(L,A,B),
    flat(B,F-[]).
