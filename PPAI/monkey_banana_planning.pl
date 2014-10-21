% state of the monkey world = state(MonkeyLocation, BoxLocation, BananaLocation)
% action(State, Action, NewState): action in State Produces NewState

action(state(onbox,Pos1,held), % Monkey, is holding banana
        eat_banana, % eat banana
        state(Pos1,Pos1,eaten)). % banana has been eaten.

action(state(onbox,Pos1,Pos1), % Monkey, box, and banana are in the same location
        grab_banana, % Grab banana
        state(onbox,Pos1,held)). % banana being held by monkey.

action(state(Pos1,Pos1,ceiling(Pos1)), % Monkey, box, and banana are in the same location
        climb_box, % Grab banana
        state(onbox, Pos1, Pos1)). % banana being held by monkey.

action(state(Pos,Pos,Loc), % Monkey and box both at Pos
        push(Pos,NewPos),   % push basket from Pos to NewPos
        state(NewPos,NewPos,Loc)). % Robot and basket now at NewPos

action(state(Pos1,Pos2,Loc), 
        go(Pos1,NewPos1),   % go from Pos1 to NewPos1
        state(NewPos1,Pos2,Loc)). 

run(Plan):-
    S0 = state(corner1,corner2,ceiling(middle)), plan(S0,state(_,_,eaten),Plan).

%plan(StartState, FinalState, Plan)
plan(State,State,[]). % To achieve State from State itself, do nothing.
plan(State1, GoalState, [Action1 | RestOfPlan]):-
    action(State1, Action1, State2), % make first action resulting in State2
    plan(State2, GoalState, RestOfPlan). % find rest of plan

