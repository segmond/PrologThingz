% tree rotation
% transforms X to Y where all commutative operatins over a constant b and an
% expression x are written in the form (x op b)
rot(X,X):-
    atomic(X).
rot(X+Y, Y1+X):-
    atomic(X), 
    rot(Y,Y1).
rot(X+Y, X1+Y1):-
    rot(X,X1),
    rot(Y,Y1).
rot(X*Y, Y1*X):-
    atomic(X),
    rot(Y,Y1).
rot(X*Y, X1*Y1):-
    rot(X,X1),
    rot(Y,Y1).
