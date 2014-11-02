% Meta-interpreter for Prolog

% interpret(+Goal)

interpret(true):-
    !.

interpret(GoalA, GoalB):-
    !,
    interpret(GoalA),
    interpret(GoalB).

interpret(Goal):-
    clause(Goal, Body),
    interpret(Body).


% Test KB
:-dynamic(parent/2).
parent(michael, cathy).
parent(melody, cathy).
parent(chalres, michael).
parent(hazle, michael).
parent(jim, melody).
parent(eleanor, melody).

:-dynamic(grandparent/2).
grandparent(X, Y):-
    parent(Z, Y),
    parent(X, Z).

% broken
test1:-
    interpret(grandparent(A,B)),
    write([A, B]), 
    nl,
    fail.

