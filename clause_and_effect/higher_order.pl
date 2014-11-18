:-op(600, yfx, '@').
% Notations
% lambda(x,y) - lambda, x is a variable and y is a term representing body of function
% f@x - application of function f to an argument x
% f@[x,y] is equivalent to f@[x]@[y] - currying
% fun(X,Y) - function named X having the definition Y
% if@[X,Y,Z] - if then else condition
% eval(X,Y) - eval expression X to determine result Y

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

% fun(inc@[X], sum@[X,1]) = var(inc, lambda(X, sum@[X,1]))
% fun(plus@[X,Y], sum@[X,1]) = var(plus, lambda(X, lambda(Y, sum@[X,1])))
% plus@[X,Y] = plus@[3]@[4].


% Builtins
fun(sum@[X,Y], callout@[sum,X,Y]).
fun(difference@[X,Y], callout@[difference,X,Y]).
fun(product@[X,Y], callout@[product,X,Y]).
fun(equal@[X,Y], callout@[equal,X,Y]).

callout(sum, X, Y, Z):- Z is X+Y.
callout(difference, X, Y, Z):- Z is X-Y.
callout(product, X, Y, Z):- Z is X*Y.
callout(equal, X, X, true):- !.
callout(equal, _, _, false):- !.

% The Evaluator

eval(callout@[Op, X, Y], Z):-
    eval(X, X1),
    eval(Y, Y1),
    callout(Op, X1, Y1, Z),
    !.

eval(if@[C,X,Y], Z):-
    eval(C, C1),
    auxif(C1, X, Y, A),
    eval(A, Z),
    !.

auxif(true, X,_,X).
auxif(false, _,X,X).

eval(F, Lx):-
    atom(F),
    fun(F@X, Y),
    make_lambda(X, Y, Lx).

make_lambda([], Y, Y).
make_lambda([X|Xs], Y, lambda(X,Z)):-
    make_lambda(Xs, Y, Z).

eval(Fx@[A], Z):-
    eval(Fx, Lx),
    eval(A, A1),
    copy_term(Lx, lambda(A1, Y)),
    eval(Y, Z),
    !.

eval(Fx@[A|As], Z):-
    eval(Fx, Lx),
    eval(A, A1),
    copy_term(Lx, lambda(A1, Y)),
    eval(Y@As, Z),
    !.
