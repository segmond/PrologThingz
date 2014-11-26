partition([], _, [], []).
partition([X|Tail], Pivot, [X|Before], After):-
    X @< Pivot, !,
    partition(Tail, Pivot, Before, After).
partition([X|Tail], Pivot, Before, [X|After]):-
    !, partition(Tail, Pivot, Before, After).


quicksort([], []).
quicksort([X|Tail], Result):-
    !, partition(Tail, X, Before, After),
    quicksort(Before, SortedBefore),
    quicksort(After, SortedAfter),
    append(SortedBefore, [X|SortedAfter], Result).
