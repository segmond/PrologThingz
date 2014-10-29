% symbolic differentiation
d(X,X,1).
d(C,X,0):-
    atomic(C).
d(-A,X,-U):-
    d(A,X,U).
d(A+B,X,U+V):-
    d(A,X,U),
    d(B,X,V).
d(A-B,X,U-V):-
    d(A,X,U),
    d(B,X,V).
d(A*B,X,B*U+A*V):-
    d(A,X,U),
    d(B,X,V).

% simplification
% s(4+6+17-3*9+1*5, X).
s(A+B,C):- !, s(A,A1),s(B,B1), oper(A1+B1,C).
s(A-B,C):- !, s(A,A1),s(B,B1), oper(A1-B1,C).
s(A*B,C):- !, s(A,A1),s(B,B1), oper(A1*B1,C).
s(X,X).

oper(A+B,C):-integer(A),integer(B),!,C is A + B.
oper(A-B,C):-integer(A),integer(B),!,C is A - B.
oper(A*B,C):-integer(A),integer(B),!,C is A * B.
oper(0+A,A):- !.
oper(A+0,A):- !.
oper(1*A,A):- !.
oper(0*A,0):- !.
oper(A*1,A):- !.
oper(A*0,0):- !.
oper(A-0,A):- !.
oper(A-A,0):- !.
oper(X,X).


% distribute negation
% use DeMorgan's Laws to push negations inwards
dn(-(-(A)),B):- !, dn(A,B).
dn(-(A+B),U+V):- !, dn(-(A),U), dn(-(B),V).
dn(-(A*B),U*V):- !, dn(-(A),U), dn(B,V).
dn(A+B,U+V):- !, dn(A,U), dn(B,V).
dn(A*B,U*V):- !, dn(A,U), dn(B,V).
dn(A,A).

/* simplify an expression */
% simp(4+6+17-3*9+1*5, X).
simp(X,Y):-
    dn(X,A), s(A,Y).

