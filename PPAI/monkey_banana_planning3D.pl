% state of the monkey world = state(MonkeyLocation, BoxLocation, BananaLocation)
% action(State, Action, NewState): action in State Produces NewState

% Monkey is holding banana, eat banana, banana has been eaten.
action(state(Pos,BoxPos,held), eat_banana, state(Pos,BoxPos,eaten)):-
    onbox(Pos,BoxPos).
% Monkey is on top of box and can grab banana, grab it.
action(state(Pos, BoxPos, BananaPos), grab_banana, state(Pos,BoxPos, NewBananaPos)):- 
    onbox(Pos,BoxPos), 
    can_grab_banana(BoxPos, BananaPos, NewBananaPos).
% monkey and box are in same location and box is under banana, climb box
action(state(Pos, Pos, BananaPos), climb_box(Pos,OnBoxPos), state(OnBoxPos, Pos, BananaPos)):- 
    under_banana(Pos,BananaPos),
    climb_box(Pos,BananaPos,OnBoxPos). 
% Monkey and box both at same position , push box from Pos to NewPos , monkey and box are in same location
action(state(Pos,Pos,Loc), push_box(Pos,NewPos), state(NewPos,NewPos,Loc)):- 
    on_ground(NewPos).
% go from pos1 to pos2
action(state(Pos,Pos2,Loc), go(Pos,NewPos1), state(NewPos1,Pos2,Loc)):-
    on_ground(NewPos1).

/* Actions & Checks */
climb_box(point(X,Y,_), point(X,Y,40),point(X,Y,20)).
onbox(point(X,Y,20), point(X,Y,0)).
on_ground(point(_,_,0)).
under_banana(point(X,Y,Z), point(X,Y,Z2)):- Z2 > Z. 
can_grab_banana(point(X,Y,Z),point(X,Y,Z2),held):- Z2 >= Z + 20.


%plan(StartState, FinalState, Plan)
plan(State,State,[]). % To achieve State from State itself, do nothing.
plan(State1, GoalState, [Action1 | RestOfPlan]):-
    action(State1, Action1, State2), % make first action resulting in State2
    plan(State2, GoalState, RestOfPlan). % find rest of plan

run(Plan):-
    Start = state(point(0,0,0), point(400,400,0),point(200,200,40)), 
    End = state(_,_,eaten),
    format('Plan is ~w -> ~w~n~n', [Start,End]),
    length(Plan, 5), plan(Start,End,Plan).
