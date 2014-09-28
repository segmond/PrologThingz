:-use_module(library(mavis)).

    /* This style is a bit more problematic, I don't like annotations much anyways.
    %% even(+X:integer) is semidet.
    even(X):-
        0 =:= X mod 2.

    %% odd(+X:integer) is semidet.
    odd(X):-
        1 =:= X mod 2.
    */

error:has_type(div_by_5, X):-
    0 =:= X mod 5.

error:has_type(odd, X):-
    1 =:= X mod 2.

%% addWeirdTypes(+X:div_by_5, +Y:odd, -Z:integer)
addWeirdTypes(X, Y, Z):-
    Z is X + Y.


even(X):-
    0 =:= X mod 2.

addPoints(point(A,B), point(C,D), point(X,Y)):-
    X is A + C,
    Y is B + D.

addEven(even(X), even(Y), Z):-
    even(X), even(Y),
    Z is X + Y.

start:-
    X = even(5), Y = even(7), addEven(X,Y,Z).
    addPoints(point(1,7), point(20, 5), Z).
