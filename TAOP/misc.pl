dosquares:-
    repeat,
    read(X),
    (
        X = stop, !
        ;
        Y is X*X, writeln(Y),
        fail
    ).

age(peter, 7).
age(ann, 5).
age(pat, 8).
age(tom, 5).

myfindall(X, Goal, Xlist):-
    call(Goal),
    assertz(queue(X)),
    fail;
    assertz(queue(bottom)),
    collect(Xlist).

collect(L):-
    retract(queue(X)), !,           % retract next solution
    ( X == bottom, !, L = []        % end of solutions?
    ;
    L = [X|Rest], collect(Rest)).   % Otherwise add X and collect the rest

test:-
    myfindall(Child, age(Child, Age), List1),
    findall(Child, age(Child, Age), List2),
    List1 = List2.


% stack
spush(L,E, [E|L]).
spop([], []).
spop([E|T], E).

% quick read
test_read:-
    see('misc.pl'),
    repeat,
    read(X),
    writeln(X),
    X = end_of_file.
