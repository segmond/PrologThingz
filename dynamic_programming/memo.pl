:- dynamic stored/1.
memo(Goal) :- ( stored(Goal) -> true ; Goal, assertz(stored(Goal)) ).

% tail recursive
%?- time(fib(43,N)).
% 88 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 7961639 Lips)
%N = 433494437 .
fib(0, A, _, A).
fib(N, A, B, F) :- 
    N1 is N - 1, 
    Sum is A + B, 
    fib(N1, B, Sum, F).

fib(N, F) :- 
    fib(N, 0, 1, F).

% Naive
%?- time(fibN(43,N)).
% 2,104,226,197 inferences, 190.174 CPU in 190.911 seconds (100% CPU, 11064741 Lips)
%N = 433494437.
fibN(0, 0):- !.
fibN(1, 1):- !.
fibN(N, NF) :-
    A is N - 1, B is N - 2,
    fibN(A, AF), fibN(B, BF),
    NF is AF + BF.

% Memoized
% faster than naive, but slower than tail recursive as values get larger
%?- time(fibM(43,N)).
% 382 inferences, 0.000 CPU in 0.000 seconds (99% CPU, 6564251 Lips)
%N = 433494437
fibM(0, 0).
fibM(1, 1).
fibM(N, NF):-
    stored(fibM(N, NF)).
fibM(N, NF) :-
    A is N - 1, B is N - 2,
    memo(fibM(A, AF)), memo(fibM(B, BF)),
    NF is AF + BF.


/* 
 * Lisp implemenation in SBCL
 * http://compgroups.net/comp.lang.lisp/prolog-in-lisp-2/1957845
* (time (fib 42))

Evaluation took:
  2.599 seconds of real time
  2.586676 seconds of total run time (2.586676 user, 0.000000 system)
  99.54% CPU
  7,778,409,814 processor cycles
  0 bytes consed
  
433494437
*/
