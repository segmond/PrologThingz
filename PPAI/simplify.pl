% ex 6.1
% terrible, need to fix
s(X+Y, C):- !,
    s(X, XS),
    s(Y, YS),
    oper(XS+YS,C).
s(X, X).
oper(X+Y, X+Y):-
    number(X), atom(Y), !.
oper(X+Y, Y+X):-
    atom(X), number(Y), !.
oper(X+Y, X+X):-
    atom(X), atom(Y), !.
oper(X+X, 2*X):- atom(X), !.
oper(X+Y, E):-
    number(X), number(Y), !,
    E is X+Y.
oper(X,X).


% ex 6.2
add_to_tail(Item, List):-
    get_tail_var(List, TailVar),
    add_to_tail_aux(Item, List-[], TailVar).

get_tail_var([H|T], TailVar):-
    var(T),
    TailVar = T.

get_tail_var([H|T], TailVar):-
    get_tail_var(T, TailVar).

% L = [a,b,c|Z]-[], L1-L2=L, L3=[z|U], Z=L3.

add_to_tail_aux(Item, L1-L2, TailVar):-
    L = [Item|Z],
    TailVar = L.

test_add_to_tail:-
    add_to_tail(d, [a,b,c|Tail]).
