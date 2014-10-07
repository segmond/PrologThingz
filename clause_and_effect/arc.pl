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

path(X,X,T).
path(X,Y,T) :-
    arc(X,Z),seen_path(Z,T),path(Z,Y,[Z|T]).

seen_path(Z, []).
seen_path(Z, [H|T]) :-
    Z \== H,
    seen_path(Z,T).
    %\+ member(Z,L).


% find path from g->c while avoiding f
% path(g,c,[f]).
% where can a go to avoiding f and d
% path(a,X[f,d]).
