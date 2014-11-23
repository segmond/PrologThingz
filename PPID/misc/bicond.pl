% inference engine for bi conditionals in prolog
:-op(950, xfx, '-:-').

prove(Goal) :-
    call(Goal).

prove(GoalA) :-
    (GoalA -:- GoalB),
    call(GoalB).

prove(GoalB) :-
    (GoalA -:- GoalB),
    call(GoalA).

canine(X) -:- dog(X).

dog(fido).
canine(rolf).

test:-
    prove(dog(X)),
    writeln(X),
    fail.
