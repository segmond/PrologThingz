:-op(600, yfx, '@').
% Notations
% lambda(x,y) - lambda, x is a variable and y is a term representing body of function
% f@x - application of function f to an argument x
% f@[x,y] is equivalent to f@[x]@[y] - currying
% fun(X,Y) - function named X having the definition Y
% if@[X,Y,Z] - if then else condition

fun(inc@[X], sum@[X,1]).
fun(hd@[[X|_]],X).
fun(tl@[[_|T]],T).

fun(factorial@[N],
    if@[    equal@[N,1],
            1,
            product@[N, factorial@[difference@[N,1]]]
        ]
    ).

fun(concatenate@[X,Y],
    if@[    equal@[X, []],
            Y,
            [hd@[X] | concatenate@[tl@[X], Y]]
        ]
    ).

fun(map@[F,L],
    if@[    equal@[L, []],
            [],
            [F@[hd@[L]] | map@[F, tl@[L]]]
        ]
    ).

