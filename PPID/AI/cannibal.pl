% cannibal and missionaries puzzle
%   Work in progress
%
%   3 cannibals and missionaries on one side of the river
%   cannibals can not outnumber missionaires on any side of the river
%   no one crosses the river without a boat

cannibal:-
    solve_cannibal([state(3,3,l)], Solution),
    reverse(Solution, [], OrderedSolution),
    show_states(OrderedSolution).


solve_cannibal([state(0,0,r)|PriorStates], [state(0,0,r)|PriorStates]).

solve_cannibal([state(M1,C1,l)|PriorStates], Solution):-
    member([M,C], [[0,1],[1,0],[1,1],[0,2],[2,0]]), % carry at least one and at most 2 across the river
    M1 >= M, % no more missionaires enter the boat than are presently on the left bank of the river
    C1 >= C, % no more cannibals enter the boat than are presently on the right bank of the river
    M2 is M1 - M, % determine how many missionaires will be on the left bank after the trip
    C2 is C1 - C, % determine how many cannibals will be on the right bank after the trip
    member([M2,C2], [[3,_], [0,_], [N,N]]), % check to see that all missionaires are safe after the trip
    \+ member(state(M2,C2,r), PriorStates), % guarantees that the program does not return to a previous state
    solve_cannibal([states(M2,C2,r), state(M1,C1,l)|PriorStates], Solution).

solve_cannibal([state(M1,C1,r)|PriorStates], Solution):-
    member([M,C], [[0,1],[1,0],[1,1],[0,2],[2,0]]),
    3 - M1 >= M,
    3 - C1 >= C,
    M2 is M1 + M,
    C2 is C1 + C,
    member([M2,C2], [[3,_], [0,_], [N,N]]),
    \+ member(state(M2,C2,l), PriorStates),
    solve_cannibal([states(M2,C2,l), state(M1,C1,r)|PriorStates], Solution).

show_states([]).
show_states([state(M,C,Location)|LaterStates]):-
    write_n_times('M', M),
    write_n_times('C', C),
    N is 6 - M - C,
    write_n_times(' ', N),
    draw_boat(Location),
    MM is 3 - M,
    CC is 3 - C,
    write_n_times('M', MM),
    write_n_times('C', CC),
    nl,
    show_states(LaterStates).

write_n_times(_, 0):- !.
write_n_times(Item, N):-
    write(Item),
    M is N - 1,
    write_n_times(Item, M).

draw_boat(l) :- write(' (____)     ').
draw_boat(r) :- write('     (____) ').

