% unify(Term1, Term2)
%   Term1 and Term2 are unified, ignoring the occurs check.

unify(X,Y):-
    var(X), var(Y), X=Y.

unify(X,Y):-
    var(X), nonvar(Y), X=Y.

unify(X,Y):-
    var(X), nonvar(Y), Y=X.

unify(X,Y):-
    nonvar(X), nonvar(Y), constant(X), constant(Y), X=Y.

unify(X,Y):-
    nonvar(X), nonvar(Y), compound(X), compound(Y), term_unify(X,Y).
