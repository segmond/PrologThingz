% state of the robot's world = state(RobotLocation, BasketLocation, RubbishLocation)
% action(State, Action, NewState): action in State Produces NewState
% we assume robot never drops rubbish to floor, and never pushes rubbish around


action(state(Pos1,Pos2,floor(Pos1)), % Robot and rubbish both at Pos1
        pickup, % Pick up rubbish from floor,
        state(Pos1,Pos2,held)). % Rubbish now held by robot.

action(state(Pos,Pos,held), % Robot and basket both at Pos
        drop, % Drop rubbish to basket
        state(Pos,Pos,in_basket)). % Rubbish now in basket.

action(state(Pos,Pos,Loc), % Robot and basket both at Pos
        push(Pos,NewPos),   % push basket from Pos to NewPos
        state(NewPos,NewPos,Loc)). % Robot and basket now at NewPos

action(state(Pos1,Pos2,Loc), 
        go(Pos1,NewPos1),   % go from Pos1 to NewPos1
        state(NewPos1,Pos2,Loc)). 

%plan(StartState, FinalState, Plan)

plan(State,State,[]). % To achieve State from State itself, do nothing.
plan(State1, GoalState, [Action1 | RestOfPlan]):-
    action(State1, Action1, State2), % make first action resulting in State2
    plan(State2, GoalState, RestOfPlan). % find rest of plan

% ?- S0 = state(door,corner2,floor(middle)),plan(S0,state(_,_,held),Plan).
% ?- S0 = state(door,corner2,floor(middle)),plan(S0,state(_,_,in_basket),Plan).
% ?- S0 = state(point(0,200),point(600,400),floor(point(300,200))),plan(S0,state(_,_,in_basket),Plan).
% ex4.1
% ?- S0 = state(door,corner2,floor(middle)), append(Plan,_,_), plan(S0,state(door,corner1,in_basket),Plan).

