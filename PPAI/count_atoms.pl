% count(+Atom, +List, -Num).
%   count how many times an atom appears in a list
count(A, [], 0).

count(A, [Z|T], NewN):-
    nonvar(Z),
    Z == A,
    count(A, T, N),
    !,
    NewN is N + 1.

count(A, [C|T], N):-
    compound(C),
    C=..LC,
    count(A, LC, N1),
    count(A, T, N2),
    !,
    N is N1 + N2.

count(A, [H|T], N):-
    count(A, T, N).
    
test1:-
    count(a, [a,b,[a,X,a], b], Z),
    writeln(Z).

test2:-
    count(b, [a,b,[a,X,a], b], Z),
    writeln(Z).

test3:-
    count(b, [a,b,c,X,foo(b,y,bar(b,b)),z], Z),
    writeln(Z).

test4:-
    count(d, [a,b,c,X,foo(b,y,bar(b,b)),z], Z),
    writeln(Z).
