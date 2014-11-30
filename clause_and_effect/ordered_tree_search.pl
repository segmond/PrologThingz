% ordered tree search

% tree is empty
ot_insert(A,[],n(A,[],[])).
% insert smaller item to the left
ot_insert(A,n(M,L,R),n(M,X,R)):-
    A < M, !,
    ot_insert(A,L,X).
% insert larger item to the right
ot_insert(A,n(M,L,R),n(M,L,X)):-
    A > M, !,
    ot_insert(A,R,X).
% insert item that exists in the tree
ot_insert(A,n(A,L,R),n(A,L,R)).


% lookup Item at the very top
ot_lookup(Item, n(Item, _,_)).
% lookup up item smaller, then go left
ot_lookup(Item, n(M,L,_)):-
    Item < M, !,
    ot_lookup(Item, L).
% lookup up item larger, then go right
ot_lookup(Item, n(M,_,R)):-
    Item > M, !,
    ot_lookup(Item, R).


% delete a node with no children
ot_delete(Item, n(Item, [],[]), []).
% delete a node on the left
ot_delete(Item, n(Item, L,[]), L).
% delete a node on the right
ot_delete(Item, n(Item, [],R), R).
% delete an item less than 
ot_delete(A, n(M,L,R), n(M,X,R)) :-
    A < M, !,
    ot_delete(A, L, X).
% delete an item more than 
ot_delete(A, n(M,L,R), n(M,L,X)) :-
    A > M, !,
    ot_delete(A, R, X).

% delete a node with two items
% seems a big buggy, doesn't balance out, FIXME
ot_delete(Item, n(Item,L,R), n(N,X,R)):-
    L = n(N,NL,NR), !,
    ot_delete(N, L, X).

% are the two trees isomorphic?
isotree([], []).
isotree(n(X, L1, R1), n(X, L2, R2)):-
    isotree(L1, L2), 
    isotree(R1, R2).
isotree(n(X, L1, R1), n(X, L2, R2)):-
    isotree(L1, R2), 
    isotree(R1, L2).

% build our binary tree
build_ot(L, X):-
    build_ot(L, [], X).
build_ot([], Acc, Acc).
build_ot([H|T], Acc,  X1):-
    ot_insert(H, Acc, NewTree),
    build_ot(T, NewTree, X1).

% traverse in tree order from left to right
traverse_ot([]).
traverse_ot(n(A,L,R)):-
    format('~w~n', [A]),
    traverse_ot(L),
    traverse_ot(R).

% traverse in less than order, sort
traverse_ot_lt([]).
traverse_ot_lt(n(A,L,R)):-
    traverse_ot_lt(L),
    format('~w~n', [A]),
    traverse_ot_lt(R).

% traverse in greater than order, sort
traverse_ot_gt([]).
traverse_ot_gt(n(A,L,R)):-
    traverse_ot_gt(R),
    format('~w~n', [A]),
    traverse_ot_gt(L).

% apply to every node of tree
apply_on_ot(_, [], []).
apply_on_ot(Func, n(A,L,R), n(X,NewL,NewR)):-
    apply_on_ot(Func, L, NewL),
    call(Func,A,X),
    format('~w -> ~w~n', [A,X]),
    apply_on_ot(Func, R, NewR).

% traverse in tree order from left to right
pretty_print_ot([], _).
pretty_print_ot(n(A,L,R), Indent):-
    NewIndent is Indent + 4,
    pretty_print_ot(R,NewIndent),
    format('~*+ ~w~n', [Indent,A]),
    pretty_print_ot(L,NewIndent).

% copy tree in order from left to right
copy_tree([],[]).
copy_tree(n(A,L,R), n(A,LT,RT)):-
    copy_tree(L, LT),
    copy_tree(R, RT).

% find largest item
find_largest_item(n(A,L,R) ,Largest):-
    find_largest_item(n(A,L,R),A,Largest).
find_largest_item([],Largest,Largest).
find_largest_item(n(A,[],[]), Acc, Largest):-
    (Acc >= A -> Largest = Acc ; Largest = A).
find_largest_item(n(A,L,R), Acc, Largest):-
    (Acc >= A -> NewAcc = Acc ; NewAcc = A),
    find_largest_item(L, NewAcc, LLarge),
    find_largest_item(R, NewAcc, RLarge),
    (LLarge >= RLarge -> Largest = LLarge ; Largest = RLarge).

% find largest item, then duplicate tree with it
%   we can find highest, and duplicate the tree with a hole in it
%   then fill it with the hole
% page 66 exercise in clause & effect
foo(n(A,L,R),NewTree):-
    foo(n(A,L,R),A,Largest,Largest,NewTree).
foo([],Largest,_,Largest,[]).
%foo(n(A,[],[]),Acc,Hole,Largest, n(Hole,[],[])):-
%    (Acc >= A -> Largest = Acc ; Largest = A).
foo(n(A,L,R), Acc, Hole,Largest, n(Hole,LT,RT)):-
    (Acc >= A -> NewAcc = Acc ; NewAcc = A),
    foo(L, NewAcc, Hole,LLarge, LT),
    foo(R, NewAcc, Hole,RLarge, RT),
    (LLarge > RLarge -> Largest = LLarge ; Largest = RLarge).


test(Z):-
    build_ot([16,17,14,15,20,10,9,8], X), 
    traverse_ot(X), 
    apply_on_ot(plus(100),X,Z).

test2:-
    build_ot([20,10,50,5,15,45,55,1,7,14,17,43,48,52,60], X), 
    pretty_print_ot(X,0),
    ot_delete(20,X,X1), 
    pretty_print_ot(X1,0).

test3:-
    build_ot([4,2,1,3], X),
    build_ot([4,2,3,1], X1),
    pretty_print_ot(X,0),
    pretty_print_ot(X1,0),
    isotree(X, X1).
