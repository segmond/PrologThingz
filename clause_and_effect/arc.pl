% acyclic directed graph

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

path(X,X).
path(X,Y) :-
    arc(X,Z),path(Z,Y).

