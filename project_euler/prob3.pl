:-use_module(library(clpfd)).

% solves the problem, but super fucking slow.  fuck!
factors(N, L):-
    findall(X, (X in 1..N, 0 #= N rem X, indomain(X)), L).

prime(P):-
    factors(P, L), L = [1, P].

solve(N, LargestPrimeFactor):-
    factors(N, Factors), include(prime, Factors, Primes), max_member(LargestPrimeFactor, Primes).

