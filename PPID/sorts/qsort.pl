partition([X|Tail], Pivot, [X|Before], After):-
    X @< Pivot, 
    !,
    partition(Tail, Pivot, Before, After).

partition([X|Tail], Pivot, Before, [X|After]):-
    !,
    partition(Tail, Pivot, Before, After).

partition([], _, [], []).
