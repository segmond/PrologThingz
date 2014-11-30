% Numerical equation solver

% solve(+(Left=Right))
%   Left=Right is an arithmetic equation containing an uninstantiated
%   variable. On exit, that variable is instantiated to a solution.

solve(Left=Right):-
    free_in(Left=Right, X),
    !,  % accept only one answer from free_in
    define_dif(X, Left=Right),
    solve_for(X).

% free_in(+Term, -Variable)
%   Variable occurs in Term and is uninstantiated.

free_in(X, X):-
    var(X).

free_in(Term, X):-
    Term \== [[]],
    Term =.. [_,Arg|Args],
    (free_in(Arg, X); free_in(Args, X)).


% define_dif(-X, +(Left=Right))
%   Defines a predicate to compute Left-Right given X.
%   Here X is uninstantiated but occurs in Left=Right

define_dif(X, Left=Right):-
    abolish(dif, 2),
    assert(
        dif(X, Dif):-
            Dif is Left-Right).

% solve_for(-Variable)
%   sets up arguments and calls solve_aux

solve_for(Variable):-
    dif(1, Dif1),
    solve_aux(Variable, 1, Dif1, 2, 1).

% solve_aux(-Variable, +Guess1, +Dif1, +Guess2, +Iteration)
%   Uses the secant method to solve for Variable
%   Guess1  - previous estimated value
%   Dif1    - What 'dif' gave with Guess1
%   Guess2  - A better estimate
%   Iteration - count of tries taken.

solve_aux(_,_,_,_,100):-
    !,
    writeln('[Gave up at 100th iteration]'),
    fail.

solve_aux(Guess2, Guess1, _, Guess2, _):-
    close_enough(Guess1, Guess2),
    !,
    writeln('[Found a satisfactory solution]').

solve_aux(Variable, Guess1, Dif1, Guess2, Iteration):-
    writeln([Guess2]),
    dif(Guess2, Dif2),
    Slope is (Dif2-Dif1) / (Guess2-Guess1),
    Guess3 is Guess2 - (Dif2/Slope),
    NewIteration is Iteration + 1,
    solve_aux(Variable, Guess2, Dif1, Guess3, NewIteration).

% close_enough(+X, +Y)
%   True if X and Y are the same number to within a factor of 1.000001.
close_enough(X, Y):-
    Quot is X/Y,
    Quot > 0.999999,
    Quot < 1.000001.

test1:-
    solve(X=1+1/X),
    writeln(X).
test2:-
    solve(X+1=1/X),
    writeln(X).
test3:-
    solve(X=1-(1/X)),
    writeln(X).
test4:-
    solve(X=cos(X)),
    writeln(X).
test5:-
    solve(X+X = X+3),
    writeln(X).
test6:-
    solve(X+X+X = X+8),
    writeln(X).
