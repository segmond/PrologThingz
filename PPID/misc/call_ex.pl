% power of call comes from the fact that a goal can be created by computation and then executed.

answer_question :-
    write('mother or father? '),
    read_atom(X),
    write('of whom? '),
    read_atom(Y),
    Q =.. [X,Who,Y), % Q will take the form of ie, mother(Who, bob)
    call(Q),
    write(Who),
    nl.


% apply(Functor, ArgList)
%   constructs and executes a query.

apply(Functor, ArgList) :-
    Goal =.. [Functor|ArgList],
    call(Goal). % since we already have Goal, call is redundant.

apply2(Functor, ArgList) :-
    Goal =.. [Functor|ArgList],
    Goal.
