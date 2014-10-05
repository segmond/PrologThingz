% exercise 3.14.1
% reverses the args of a predicate
reverse(L,R):-
    reverse_aux(L, [], R).
reverse_aux([H|T], Stack, R):-
    reverse_aux(T, [H|Stack], R).
reverse_aux([], R, R).

reverse_args(F,R) :-
    F =.. [H|T],
    reverse(T, RT),
    R =.. [H|RT].
