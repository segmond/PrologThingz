% directed graph
link(a,b).
link(a,c).
link(b,d).
link(c,d).
link(c,f).
link(d,e).
link(d,f).
link(f,a).

path(N,N).
%:path(Start,End):-
%    link(Start,End).
path(Start,End):-
    link(Start,MidPoint),
    path(MidPoint,End).

ppath(N,N).
ppath(Start,End):-
    link(Start,End).
ppath(Start,End):-
    ppath(Start,End,[]).
ppath(Start,End,Acc):-
    link(Start,MidPoint),
    \+ seen_path(MidPoint, Acc),
    ppath(MidPoint,End, [MidPoint|Acc]).

seen_path(H, [H|T]).
seen_path(H, [X|T]):-
    seen_path(H,T).

path2(N,N,[N]).
path2(S,E,[S|R]):-
    link(S,NN),
    path2(NN,E,R).

/*
%find all paths from a to end with 4 possible paths
length(Path,4),path2(a,End,Path).

%find all paths
append(Path,_,_),path2(a,End,Path).
*/
