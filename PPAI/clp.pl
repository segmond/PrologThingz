%
:-use_module(library(clpfd)).


% convert(Var, Num) works, but convert(Num, Var) fails
convert(Centigrade, Fahrenheit):-
    Centigrade is (Fahrenheit - 32)* 5/9.

% works both ways
clp_convert(Centigrade, Fahrenheit):-
    Centigrade #= (Fahrenheit - 32)* 5/9.

test:-
    X + 1 #= 5, writeln(X).


