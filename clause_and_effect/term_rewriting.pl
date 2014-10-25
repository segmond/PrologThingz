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
