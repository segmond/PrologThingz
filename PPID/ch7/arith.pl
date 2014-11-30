% A homemade substitute for "is"
%
:-op(700, xfx, :==).

Result :== X + Y :-
	!,
	Xvalue :== X,
	Yvalue :== Y,
	Result is Xvalue + Yvalue.

Result :== X - Y:-
	!,
	Xvalue :== X,
	Yvalue :== Y,
	Result is Xvalue - Yvalue.

Result :== X / Y:-
	!,
	Xvalue :== X,
	Yvalue :== Y,
	Result is Xvalue / Yvalue.

Result :== X * Y:-
	!,
	Xvalue :== X,
	Yvalue :== Y,
	Result is Xvalue * Yvalue.

% reciprocal
Result :== rec(X) :-
	!,
	Xvalue :== X,
	Result is 1 / Xvalue.

Term :== Term :-
    !,
    number(Term).

_ :== Term :-
    format("Error can't evaluate ~w~n", [Term]),
    !,
    fail.
