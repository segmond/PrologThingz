:-load_foreign_library(partial_math_funcs).
start:-
    format('add(17,23,X)~n'),
    add(17,23,X), format('** 17 + 23 is [~w]~n', X),

    format('add(Y,20,7)~n'),
    add(Y,20,7), format('** [~w] + 20 is 7~n', Y),

    format('add(20,Y,8)~n'),
    add(20,Z,8), format('** 20 + [~w] is 8~n', Z).
