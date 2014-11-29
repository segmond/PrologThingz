% insert(+NewItem, -Tree, +NewTreE)
%   Inserts an item into a binary tree.

insert(NewItem, empty, tree(NewItem, empty, empty)) :- !.

insert(NewItem, tree(Element, Left, Right), tree(Element, NewLeft, Right)) :-
    NewItem @< Element,
    !,
    insert(NewItem, Left, NewLeft).

insert(NewItem, tree(Element, Left, Right), tree(Element, Left, NewRight)) :-
    insert(NewItem, Right, NewRight).
