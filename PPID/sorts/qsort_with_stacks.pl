partition([], _, [], []).
partition([X|Tail], Pivot, [X|Before], After):-
    X @< Pivot, !,
    partition(Tail, Pivot, Before, After).
partition([X|Tail], Pivot, Before, [X|After]):-
    !, partition(Tail, Pivot, Before, After).


% quicksort, improved with stacks
quicksort(L, R):-
    squicksort(L, [], R).

squicksort([X|Tail], Stack, Result):-
    !, partition(Tail, X, Before, After),
    squicksort(After, Stack, NewStack),
    squicksort(Before, [X|NewStack], Result).
squicksort([], Stack, Stack).
