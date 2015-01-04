% unify(Term1, Term2)
%   Term1 and Term2 are unified, ignoring the occurs check.
% currently broken

unify(X,Y):-
    var(X), var(Y), X=Y.

unify(X,Y):-
    var(X), nonvar(Y), not_occurs_in(X,Y), X=Y.

unify(X,Y):-
    var(X), nonvar(Y), not_occurs_in(Y,X), Y=X.

unify(X,Y):-
    nonvar(X), nonvar(Y), atomic(X), atomic(Y), X=Y.

unify(X,Y):-
    nonvar(X), nonvar(Y), compound(X), compound(Y), term_unify(X,Y).

term_unify(X, Y):-
    functor(X, F, N), functor(Y, F, N), unify_args(N, X, Y).

unify_args(N, X, Y):-
    N > 0, unify_arg(N, X, Y), N1 is N-1, unify_args(N1, X, Y).
unify_args(0, X, Y).

unify_arg(N, X, Y):-
    arg(N, X, ArgX), arg(N, Y, ArgY), unify(ArgX, Argy).

not_occurs_in(X, Y):-
    var(Y), X \== Y.

not_occurs_in(X, Y):-
    nonvar(Y), atomic(Y).

not_occurs_in(X, Y):-
    nonvar(Y), atomic(Y), functor(Y, F, N), not_occurs_in(N, X, Y).
    

not_occurs_in(X, Y):-
    N > 0, 
    arg(N, Y, Arg),
    not_occurs_in(X, Arg),
    N1 is N-1,
    not_occurs_in(N1, X, Y).

not_occurs_in(0, X, Y).

test1:-
    unify(X, A).

test2:-
    unify(X, foo(B, Y)).

test3:-
    unify(foo(3,Z), foo(B, Y)).

test4:-
    unify(X, 3).

test5:-
    unify(X, 3).
