%
my_rewrite_term(T, R):-
    T =.. A,
    rewrite_term_aux(A, R).

rewrite_term_aux([], []).
rewrite_term_aux([b|T], [a|R]):-
    rewrite_term_aux(T, R).
rewrite_term_aux([H|T], [H|R]):-
    rewrite_term_aux(T, R).

    

% section 7.1
rewrite(a, b):-  % change all a to b
    !.
rewrite(X, X).  % leave everything alone

rewrite_term(X, X):-
    var(X),
    !.

rewrite_term(X, Y):-
    atomic(X),
    !,
    rewrite(X, Y).

rewrite_term(X, Y):-
    X =.. XList,
    rewrite_aux(XList, YList),
    Y =.. YList.

rewrite_aux([], []).
rewrite_aux([First|Rest], [NewFirst|NewRest]):-
    rewrite_term(First, NewFirst),
    rewrite_aux(Rest, NewRest).

/*
?- my_rewrite_term(foo(a,[b,a(X), d]), X).
X = [foo, a, [b, a(X), d]].
*/

