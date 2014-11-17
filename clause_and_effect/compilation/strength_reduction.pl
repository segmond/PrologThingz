reduce(X+0, Y):-
    reduce(X, Y).
reduce(X+1, inc(Y)):-
    reduce(X, Y).
reduce(X*1, Y):-
    reduce(X, Y).
reduce(X*0, 0).
reduce(X*C, shift(Y, N)):-
    power2(C, N), 
    reduce(X, Y).

power2(2, 1).
power2(4, 2).
power2(8, 3).
power2(256, 8).
power2(16777216, 24).
