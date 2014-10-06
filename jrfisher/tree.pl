/* The tree database */ 

:- op(500,xfx,'is_parent'). 

a is_parent b.    c is_parent g.     f is_parent l.     j is_parent q. 
a is_parent c.    c is_parent h.     f is_parent m.     j is_parent r. 
a is_parent d.    c is_parent i.     h is_parent n.     j is_parent s. 
b is_parent e.    d is_parent j.     i is_parent o.     m is_parent t. 
b is_parent f.    e is_parent k.     i is_parent p. 

:- op(500,xfx,'is_sibling_of').
X is_sibling_of Y :-
    Z is_parent X,
    Z is_parent Y,
    X \== Y.

:- op(500,xfx,'is_same_level_as').
X is_same_level_as X :- !.
X is_same_level_as Y :-
    A is_parent X,
    B is_parent Y,
    A is_same_level_as B.

:- op(500,xfx,'has_depth').

a has_depth 0:- !.
Node has_depth D :-
    Mother is_parent Node,
    Mother has_depth D1,
    D is D1 + 1.

/* Locate note by finding a path froom root down to the node */
locate(Node) :- 
    path(Node),
    writeln(Node).

path(a).
path(Node) :-
    Mother is_parent Node,
    path(Mother),
    write(Mother),
    write(' --> ').
