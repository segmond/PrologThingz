:- begin_tests(predicate_types).
:- use_module(predicate_types).

test(add_even):-
    X = even(4), Y = even(8), 
    add_even(X,Y,even(12)).

test(add_even,[fail]):-
    X = even(4), Y = even(8), 
    add_even(X,Y,even(13)).

test(add_even,[fail]):-
    X = even(5), Y = even(8), 
    add_even(X,Y,even(13)).

test(add_even,[fail]):-
    X = even(6), Y = even(7), 
    add_even(X,Y,even(13)).

test(add_weird_types):-
    add_weird_types(25, 3, 28).

test(add_weird_types, [error(type_error(div_by_5, 21))]):-
    add_weird_types(21, 3, 28).

test(add_weird_types, [error(type_error(odd, 4))]):-
    add_weird_types(25, 4, 28).

test(add_points):-
    add_points(point(1,7), point(20, 5), point(21,12)).

test(add_points, [fail]):-
    add_points(point(1,7), point(20, 5), line(21,12)).

:- end_tests(predicate_types).
