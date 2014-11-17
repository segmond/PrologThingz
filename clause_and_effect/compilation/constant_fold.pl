% fold constants, ie, fold 2+3+a into 5+a

fold(X, X):- atomic(X).
fold(X+Y, Z):-
    fold(X, X1), fold(Y, Y1), operator(X1+Y1, Z).
fold(X*Y, Z):-
    fold(X, X1), fold(Y, Y1), operator(X1*Y1, Z).
fold(C*(X+Y), Z):-
    integer(C), fold((C*X)+(C*Y), Z).

operator(X+Y, Z):- integer(X), integer(Y), Z is X+Y.
operator(X*Y, Z):- integer(X), integer(Y), Z is X*Y.
operator(X,X).



