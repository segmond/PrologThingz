%
:-use_module(library(clpfd)).
:-use_module(library(clpr)).
:-use_module(library(clpq)).

% CLP
%   R = real numbers
%   Z = integers
%   Q = rational numbers
%   B = booleans
%   FD = user defined finite domains

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


test6(X):-
    test6a(X),
    test6b(X),
    test6c(X).

test6a(X):-
    X #=< 100.
test6b(X):-
    X #>= 20.
test6c(X):-
    labeling([min(X)], [X]).

run_test6:-
    Z in -100..500, test6(Z), writeln(Z).


% clpr
test7(X, Y):-
    {3*X - 2*Y = 6, 2*Y = X}.

test8(Z):-
    {Z =< X-2, Z =< 6-X, Z+1 = 2}.

/*
?- {X =< 5}, maximize(X),T = X + 2.
X = 5.0,
T = 5.0+2 .

?- {X =< 5}, maximize(X),{T = X + 2}.
X = 5.0,
T = 7.0 .

?- {X =< 5}, sup(X, Z),{T = X + 2}.
Z = 5.0,
{T=2.0+X, X=<5.0} .

?- {X =< 5}, sup(X, Z),{T = X + 2},  maximize(T).
X = Z, Z = 5.0,
T = 7.0 .
*/


fib(N, F):-
    N = 0, F = 1
    ;
    N = 1, F = 1
    ;
    N >= 2,
    N1 is N - 1, fib(N1, F1),
    N2 is N - 2, fib(N2, F2),
    F is F1 + F2.

clp_fib(N, F):-
    {N = 0, F = 1} ;
    {N = 1, F = 1} ;
    {
        N >= 2,
        F = F1 + F2, 
        N1 = N - 1, 
        N2 = N - 2
    }, 
    clp_fib(N1, F1),
    clp_fib(N2, F2).

