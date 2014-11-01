% meta programming 

/*
? = functor(foo(a, b, c,), F, Arity).
F = foo,
Arity = 3

?- arg(2, foo(a, b, c), A).
A = b.

?- X =.. [member, A, L].
X = member(A, L).

:-op
assert/
retract/
clause/
call
*/

% unifty(Predicate1, Predicate2)
unify(Predicate1, Predicate2):-
    functor(Predicate1, Func1, Arity1),
    functor(Predicate2, Func2, Arity2),
    ucompare(Func1, Func2, Arity1, Arity2),
    Predicate1 =.. [_|Terms1],
    Predicate2 =.. [_|Terms2],
    compare_args(Terms1, Terms2).

ucompare(F,F,A,A).
ucompare(_,_,_,_):- 
    !, 
    fail.

compare_args([], []).
compare_args([H|Terms1], [H2|Terms2]):-
    H = H2, 
    ucompare(H,H2,0,0),
    compare_args(Terms1, Terms2).

/*
?- unify(foo(a,b), foo(a,b)).
true .

?- unify(foo(a,b), foo(a,d)).
false.

?- unify(foo(a,b), foo(a,X)).
X = b .

?- unify(foo(Y,b), foo(a,X)).
Y = a,
X = b .

?- unify(foo(Y,b), foo(Z,X)).
Y = Z,
X = b .

?- unify(foo(1,b), foo(k,X)).
false.

*/
