% meta interpreter for prolog

interpret(true):- !.

interpret((GoalA, GoalB)):- !,
    interpret(GoalA),
    interpret(GoalB).

interpret(not(Goal)):- !,
    not(clause(Goal, Body)),
    interpret(Body).

interpret(Goal):-
    catch(
            (clause(Goal, Body), interpret(Body)), 
            Error,
            call(Goal)
          ).

% test KB
:-dynamic(dog/1).
dog(fido).
dog(bob).

cat(felix).

parent(michael, cathy).
parent(melody, cathy).
parent(charles_gordon, michael).
parent(hazel, michael).
parent(jim, melody).
parent(eleanor, melody).

grandparent(X, Y):-
    parent(Z, Y),
    parent(X, Z).

count_list([], 0).
count_list([H|T], inc(N)):-
    count_list(T, N).

%    ?- interpret(count_list([a,b,c,d], X)).
%    X = inc(inc(inc(inc(0)))).

test:-
    interpret(grandparent(A,B)),
    writeln([A,B]),
    fail.
