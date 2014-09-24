:- use_module(library('clp/bounds')).
% with clp/bounds we can label inside of predict, if this was clpfd, we label outside

sendmore(Digits) :-
   Digits = [S,E,N,D,M,O,R,Y],
   Digits in 0..9,
   S #\= 0,
   M #\= 0,
   all_different(Digits),
                1000*S + 100*E + 10*N + D
              + 1000*M + 100*O + 10*R + E
   #= 10000*M + 1000*O + 100*N + 10*E + Y,
   label(Digits).
