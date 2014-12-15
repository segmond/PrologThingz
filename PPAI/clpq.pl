%
:-use_module(library(clpq)).
/*
?- clp_fib(100, F).
F = 573147844013817084101 .

?- clp_fib(N, 573147844013817084101).
N = 100 .

 */

fib(N, A, B, F) :- 
    { N = 0, F = 1};
    { N = 1, F = 1};
    {   
        N >= 2,
        N1 = N - 1, 
        Acc = B,
        Sum = A + B,
        F = F1 + Acc,
        F1 >= N1    % to not run infinitly for unsatisfiable question clp_fib(N, 4).
    }, 
    fib(N1, Acc, Sum, F1).

clp_fib(N, F) :- 
    fib(N, 0, 1, F).


clp_plus(X, Y, Z):-
    {Z = X + Y}.

fact(N, F):-
    {N = 0, F = 1 };
    {
        N > 0,
        N1 = N - 1,
        F = N * F1
    },
    fact(N1, F1).
