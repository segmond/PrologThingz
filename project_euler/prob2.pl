:- dynamic stored/1.
memo(Goal) :- ( stored(Goal) -> true ; Goal, assertz(stored(Goal)) ).

fib(0, A, _, A).
fib(N, A, B, F):-
    N1 is N - 1,
    Sum is A + B,
    fib(N1, B, Sum,F).
fib(0,1).
fib(N,F):-
    N > 0,
    N1 is N+1,
    fib(N1, 0, 1, F).

%add A to B only if B is even and return the result, else return A
addIfEven(A, B, Res):-
    (0 is mod(B, 2) ->
        Res is A + B; Res = A).

%count's upward from 0 to infinity
%get fib of count and if the result is less than the limit 
%add it else return the total so far
sumUpWhileBelow(Limit,Cnt,TotalEvenFib,R):-
    FibCnt is Cnt+1,
    memo(fib(FibCnt,FibRes)),
    (FibRes =< Limit ->
        (addIfEven(TotalEvenFib,FibRes, NewTotal),
        sumUpWhileBelow(Limit,FibCnt,NewTotal,R))
    ;
        fin(TotalEvenFib,R)
    ).
fin(R,R).

sumUpWhileBelow(N,R):-
    sumUpWhileBelow(N,0,0,R).
