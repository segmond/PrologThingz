%
:-op(100, xfx, at).
:-op(50, xfx, :).
% Start from riva at 8:00, land in limone at 8:35, contine to malceinse, land at 8:55
timetable([ riva at 8:00, limone at 8:35, malcesine at 8:55 ]).
timetable([ riva at 9:10, torbole at 9:25, limone at 9:55, malcesine at 10:15]).
timetable([ riva at 9:45, torbole at 10:00, limone at 10:30, malcesine at 10:50]).
timetable([ riva at 11:45, torbole at 12:00, limone at 12:30, malcesine at 12:50]).
timetable([ riva at 13:10, limone at 13:32, malcesine at 13:45 ]).
timetable([ riva at 14:05, limone at 14:40, malcesine at 15:00 ]).
timetable([ riva at 15:00, limone at 15:36, malcesine at 15:57, campione at 16:13]).
timetable([ riva at 16:20, torbole at 16:35, limone at 17:05, malcesine at 17:25]).
timetable([ riva at 18:05, torbole at 18:20, limone at 18:50,malcesine at 19:10]).

timetable([ malcesine at 9:00, limone at 9:20, torbole at 9:50, riva at 10:05 ]).
timetable([ malcesine at 10:25, limone at 10:50, torbole at 11:20, riva at 11:35 ]).
timetable([ malcesine at 11:25, limone at 11:45, riva at 12:20 ]).
timetable([ campione at 12:55, malcesine at 13:12, limone at 13:34, riva at 14:10 ]).
timetable([ malcesine at 13:45, limone at 13:59, riva at 14:20 ]).
timetable([ malcesine at 15:05, limone at 15:25, riva at 16:00 ]).
timetable([ malcesine at 16:30, limone at 16:50, torbole at 17:20, riva at 17:35 ]).
timetable([ malcesine at 18:15, limone at 18:35, torbole at 19:05, riva at 19:20 ]).
timetable([ malcesine at 19:15, limone at 19:35, torbole at 20:05, riva at 20:20 ]).

sail(PlaceTime1, PlaceTime2):-
    timetable(Route),
    append(_, [PlaceTime1, PlaceTime2 |_], Route).

time_diff(H1:M1, H2:M2, Diff):-
    Diff is ((H2 - H1) * 60) - M1 + M2.

before(Time1,Time2):-
    time_diff(Time1,Time2,Diff),
    Diff > 0.

%usage
% schedule(riva at 9:10, malcesine at FinaTime, Schedule).
% schedule(campione at Start, campione at End, Schedule), member(stay(riva,T1,T2), Schedule), time_diff(T1,T2,D), D>= 45.

% in no more than 15 trips, start at and end at riva, stay at campione for at least 45 minutes
% length(MaxList,15), append(Schedule,_,MaxList), schedule(riva at Start, riva at End, Schedule), member(stay(campione,T1,T2), Schedule), time_diff(T1,T2,D), D>= 45.

schedule(Start, Destination, [depart(Start), arrive(Next) | Rest]):-
    list(Rest),                             % rest short schedules first
    sail(Start,Next),
    rest_schedule(Next, Destination, Rest).

rest_schedule(Place,Place,[]).              % already at destination, empty schedule

rest_schedule(Here, Dest, [arrive(Next) | Rest]):-
    sail(Here,Next),                        % stay onboard, continue immediately to town next
    rest_schedule(Next,Dest,Rest).

rest_schedule(Place at Time1, Dest, [stay(Place,Time1,Time2)|Rest]):-
    sail(Place at Time2,_),                 % stay at place until Time2
    before(Time1,Time2),                    % Time2 is a later depature time
    schedule(Place at Time2, Dest, Rest).   % continue at Time2

list([]).
list([_|L]):-
    list(L).


%
foo(Schedule):-
    schedule(riva at Start, riva at End, Schedule), % start at riva, end at at riva
    before(9:00, Start),                            % start trip after 9pm
    before(End, 18:30),                             % end trip before 18:30

    member(stay(limone, T1,T2), Schedule),          % include stay at limone
    before(11:30,T1),                               % arive at limone between 11:30 
    before(T1, 13:00),                              %   and 13:00
    time_diff(T1,T2,D1), D1 >= 90,                  % stay at limone for at least 90 min
    %before(T2, 14:30),                             % finish lunch before 2:30pm, this is wrong

    member(stay(malcesine,M1,M2), Schedule),        % include stay at malcesine
    time_diff(M1,M2,D2), D2 >= 90.                  % stay at malcesine for at least 90 min
