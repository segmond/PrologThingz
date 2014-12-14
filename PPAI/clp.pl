%
:-use_module(library(clpfd)).


% convert(Var, Num) works, but convert(Num, Var) fails
convert(Centigrade, Fahrenheit):-
    Centigrade is (Fahrenheit - 32)* 5/9.

% works both ways
clp_convert(Centigrade, Fahrenheit):-
    Centigrade #= (Fahrenheit - 32)* 5/9.

test1:-
    X + 1 #= 5, writeln(X).


test2(F):-
    clp_convert(35, F), label([F]).


% Bratko pg179 chapter 7 problem
test3(Tf):-
    [Ta,Tb,Tc,Td,Tf] ins 0..10,
    % Ta #= 0,
    Ta + 2 #=< Tb,
    Ta + 2 #=< Tc,
    Tb + 3 #=< Td,
    Tc + 5 #=< Tf,
    Td + 4 #=< Tf,
    labeling([min(Tf)], [Tf]).


test4(MinTf):-
    Ta #= 0,        % Task a cannot start before time 0
    Ta + 2 #=< Tb,  % Task b cannot start before a has finished
    Ta + 2 #=< Tc,  % a precedes c
    Tb + 3 #=< Td,  % b precedes d
    Tc + 5 #=< Tf,  % c finished by finishing time Tf
    Td + 4 #=< Tf,  % d finished by Tf
    fd_inf(Tf, MinTf).  % look for schedules with minimal finishing time

test5:-
    [Dx, Dy] ins 0..10.
