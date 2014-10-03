:-module(predicate_types,
    [   add_weird_types/3,
        add_points/3,
        add_even/3
    ]).

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

%% add_weird_types(+X:div_by_5, +Y:odd, -Z:integer)
add_weird_types(X, Y, Z):-
    Z is X + Y.


even(X):-
    0 =:= X mod 2.

add_points(point(A,B), point(C,D), point(X,Y)):-
    X is A + C,
    Y is B + D.

add_even(even(X), even(Y), even(Z)):-
    even(X), even(Y),
    Z is X + Y.

/* just testing, too long and winded tho */
:- meta_predicate add_odd(2).
odd(X):-
    1 =:= X mod 2.
add_odd(X, Y, even(Z)):-
    callable(X), callable(Y),
    call(X),call(Y),
    odd(Xval) =  X,
    odd(Yval) = Y,
    Z is Xval + Yval.


/* TODO: checkout the type_check pack 
http://tomschrijvers.blogspot.com/2008/02/types-for-prolog.html
*/
