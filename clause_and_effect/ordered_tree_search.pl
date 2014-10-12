% ordered tree search

% tree is empty
ot_insert(A,[],n(A,[],[])).
% insert smaller item to the left
ot_insert(A,n(M,L,R),n(M,X,R)):-
    A < M,
    ot_insert(A,L,X).
% insert larger item to the right
ot_insert(A,n(M,L,R),n(M,L,X)):-
    A > M,
    ot_insert(A,R,X).
% insert item that exists in the tree
ot_insert(A,n(A,L,R),n(A,L,R)).


% lookup Item at the very top
ot_lookup(Item, n(Item, _,_)).
% lookup up item smaller, then go left
ot_lookup(Item, n(M,L,R)):-
    Item < M,
    ot_lookup(Item, L).
% lookup up item larger, then go right
ot_lookup(Item, n(M,L,R)):-
    Item > M,
    ot_lookup(Item, R).


