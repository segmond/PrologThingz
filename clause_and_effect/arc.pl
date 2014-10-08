% acyclic directed graph

arc(d, a).
arc(g, h).
arc(g, d).
arc(e, d).
arc(h, f).
arc(e, f).
arc(a, e).
arc(a, b).
arc(b, f).
arc(b, c).
arc(f, c).

path(X,Y):-
    path(X,Y,[]).

% succeed is there's any path from X to Y without passing through T
path(X,X,_).
path(X,Y,T) :-
    arc(X,Z),seen_path(Z,T),path(Z,Y,[Z|T]).

seen_path(_, []).
seen_path(Z, [H|T]) :-
    Z \== H,
    seen_path(Z,T).
    %\+ member(Z,L).


% find path from g->c while avoiding f
% path(g,c,[f]).
% where can a go to avoiding f and d
% path(a,X[f,d]).

% find path using partial maps
% we can give as one of the arguments to the path a complete list of all the nodes in the graph.
% then, as a node is visited, it is struct off the list, if there's no element to strike off,
% then the node is not to be visited.
% reduce is also the same as takeout
% take out X
reduce([X|T], X,T).
reduce([H|T], X,[H|L]) :-
    reduce(T,X,L).

ppath(X,X,L).
ppath(X,Y,T) :-
    arc(X,Z), reduce(T,Z,L), ppath(Z,Y,L).

