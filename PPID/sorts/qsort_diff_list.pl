partition([], _, [], []).
partition([X|Tail], Pivot, [X|Before], After):-
    X @< Pivot, !,
    partition(Tail, Pivot, Before, After).
partition([X|Tail], Pivot, Before, [X|After]):-
    !, partition(Tail, Pivot, Before, After).


quicksort([], X/X).
quicksort([X|Tail], Result/ResultTail):-
    !, partition(Tail, X, Before, After),
    quicksort(Before, Result/[X|Z]),
    quicksort(After, Z/ResultTail).
