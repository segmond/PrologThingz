multipleOfM(M,N):-
    0 is mod(N, M). 

divisibleBy3or5(N):-
    (multipleOfM(3,N) ; multipleOfM(5,N)).


range(F,F,[F]).
range(From, To, [From|L]):-
    From < To,
    F1 is From + 1,
    range(F1, To, L).

start(R2):-
    range(1,999,L),
    include(divisibleBy3or5, L, R),
    sum_list(R,R2).
