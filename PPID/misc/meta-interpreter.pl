% meta interpreter for prolog

interpret(true):- !.

interpret((GoalA, GoalB)):- !,
    interpret(GoalA),
    interpret(GoalB).

interpret(Goal):-
    clause(Goal, Body),
    interpret(Body).

% test KB
:-dynamic(dog/1).
dog(fido).

cat(felix).

count_list([], 0).
count_list([H|T], inc(N)):-
    count_list(T, N).

%    ?- interpret(count_list([a,b,c,d], X)).
%    X = inc(inc(inc(inc(0)))).
