% heapify a tree
%   The elements of the complete binary tree Tree have been adjusted to form the binary tree Heap,
%   which has the same shape as Tree and satisfies the heapy property that the value of each
%   parent node is greater than or equal to the value of it's children
heapify(void, void).
heapify(tree(X,L,R), Heap):-
    heapify(L, HeapL),
    heapify(R, HeapR),
    adjust(X, HeapL, HeapR, Heap).

adjust(X, HeapL, HeapR, tree(X, HeapL, HeapR)):-
    greater(X, HeapL),
    greater(X, HeapR).

adjust(X, tree(X1,L,R), HeapR, tree(X1, HeapL, HeapR)):-
    X < X1,
    greater(X1, HeapR),
    adjust(X, L, R, HeapL).

adjust(X, HeapL, tree(X1,L,R), tree(X1, HeapL, HeapR)):-
    X < X1,
    greater(X1, HeapL),
    adjust(X, L, R, HeapR).

greater(X, void).
greater(X, tree(X1, L, R)):-
    X >= X1.


test:-
    Tree = tree(100, tree(119, void, void), tree(118, tree(171, void, tree(112, tree(151, void, void), tree(132, void, void))), void)),
    writeln(Tree),
    heapify(Tree, Heap),
    writeln(Heap).
