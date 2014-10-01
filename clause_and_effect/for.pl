% implementation of a for loop
for(0,Goal):- !.
for(N,Goal):-
    N > 0,
    call(Goal),
    M is N-1,
    for(M,Goal),
    !.

% for loop while stepping
for_step(N,Step,Goal):-
    for_step(0,Step,N,Goal).
    
for_step(C,Step,N,Goal):-
    N >= 0,
    call(format('hello ~w~n'), C),
    C1 is C+Step,
    M is N-Step,
    for_step(C1,Step,M,Goal),
    !.

for_step(N,0,Goal):- !.

start:-
    for_step(16,2, format('hello ~n')).

