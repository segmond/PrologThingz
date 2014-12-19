%my_ground(Term)
%   Term is a my_ground term

my_ground(Term):-
    nonvar(Term), atomic(Term).

my_ground(Term):-
    nonvar(Term), 
    compound(Term),
    functor(Term, F, N),
    my_ground(N, Term).

my_ground(N, Term):-
    N > 0,
    arg(N, Term, Arg),
    my_ground(Arg),
    N1 is N-1,
    my_ground(N1, Term).

my_ground(0, Term).
