xnot(Goal) :- 
    call(Goal), !, fail.
xnot(_).

not_integer(N):-
    integer(N), !, fail.
not_integer(_).

% reptition through backtracking

typewriter:-
    repeat,
       get0(C),
    C = 10,
    !.
