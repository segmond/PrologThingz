%
solve:-
    abolish(known, 3),
    define(known, 3),
    top_goal(X),
    write('The answer is '), write(X), nl.

solve:-
    write('No anser found.'), nl.
