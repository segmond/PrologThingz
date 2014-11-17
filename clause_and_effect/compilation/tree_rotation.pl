% Tree rotation
% Transforms X to Y where all commutative operations over 
%  a constant "b" and an expression "x"
%  are written in the form (x op b)
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

rot(X, X, 0):-
    atomic(X).
rot(X+Y, A+B, W):-
    rot(X,X1,Wx),
    rot(Y,Y1,Wy),
    swop(Wx, Wy, X1, Y1, A, B, W).
rot(X*Y, A*B, W):-
    rot(X,X1,Wx),
    rot(Y,Y1,Wy),
    swop(Wx, Wy, X1, Y1, A, B, W).

swop(Wx, Wy, X, Y, X, Y, Wx):-
    Wx > Wy,
    !.
swop(Wx, Wy, X, Y, X, Y, Wx):-
    Wy > Wx,
    !.
swop(W, W, X, Y, X, Y, N):-
    N is W + 1.
