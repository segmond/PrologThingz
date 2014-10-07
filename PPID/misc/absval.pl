% absolute value
absval(X,R) :-
    X < 0 -> R is 0-X ; R=X.
