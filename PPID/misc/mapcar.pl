% mapcar(Functor,List,Result)
%   applys each element of a list to a functor and returns the result.

plus1(X,R) :-
    plus(1,X,R).

times5(X,R) :-
    R is X * 5.

mapcar(Functor, List, Result) :-
    mapcar_aux(Functor,List,Result).

mapcar_aux(Functor, [H|T], [GoalRes|Result]) :-
    Goal =.. [Functor, H, GoalRes],
    Goal,
    mapcar_aux(Functor, T, Result).

mapcar_aux(Functor, [], []).


test :-
    L = [10,2,3],
    format('Testing List ~w~n', [L]),
    mapcar(plus1, L, R1),
    format('mapcar plus1 -> ~w~n', [R1]), 
    mapcar(times5, L, R2),
    format('mapcar times5 -> ~w~n', [R2]).
