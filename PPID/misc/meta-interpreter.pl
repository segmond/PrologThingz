% meta interpreter for prolog

interpret(true):- !.

interpret((GoalA, GoalB)):- !,
    interpret(GoalA),
    interpret(GoalB).

interpret(Goal):-
    clause(Goal, Body),
    interpret(Body).

% test KB
:-dynamic(dog/1).
dog(fido).
cat(felix).
