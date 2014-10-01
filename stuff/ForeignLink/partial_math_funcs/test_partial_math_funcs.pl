:-load_foreign_library(partial_math_funcs).
start:-
    format('add(17,23,X)~n'),
    add(17,23,X), format('** 17 + 23 is [~w]~n', X),

    format('add(Y,20,7)~n'),
    add(Y,20,7), format('** [~w] + 20 is 7~n', Y),

    format('add(20,Y,8)~n'),
    add(20,Z,8), format('** 20 + [~w] is 8~n', Z).


count_down(0).
count_down(X):-
    writeln(X),
    add(1,Y,X),
    count_down(Y).


count_up(X):-
    count_up(0,X).
count_up(X,A):-
    writeln(X),
    add(X,1,Y),
    Y < A,
    count_up(Y,A).
count_up(_).
