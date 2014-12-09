% satisfiable(Formula)
%   There is a true instance of the boolean formula
satisfiable(true).
satisfiable(band(X,Y)):-
    satisfiable(X),
    satisfiable(Y).
satisfiable(bor(X,_)):-
    satisfiable(X).
satisfiable(bor(_,Y)):-
    satisfiable(Y).
satisfiable(bnot(X)):-
    invalid(X).

% invalid(Formula)
%   There is a false instance of the boolean formula
invalid(false).
invalid(bor(X,Y)):-
    invalid(X),
    invalid(Y).
invalid(band(X,_)):-
    invalid(X).
invalid(band(_,Y)):-
    invalid(Y).
invalid(bnot(Y)):-
    satisfiable(Y).


test1:-
    satisfiable(band(true, true)).

test2:-
    satisfiable(band(true, false)).

test3:-
    satisfiable(bor(true, false)).

