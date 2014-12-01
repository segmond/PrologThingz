% ex 6.1
% a bit better

% simplify an expression
simplify(Expr, Simplified):-
    simplify_aux(Expr, DirtyExpr),
    clean_up(DirtyExpr, Simplified).

% simplify, shift atoms to the left and numbers to the right
simplify_aux(X+Y, C):-
    number(X), number(Y), !,
    C is X+Y.
simplify_aux(X+Y, Y+X):-
    number(X), atom(Y), !. 
simplify_aux(X+Y, X+Y):- 
    atom(X), number(Y), !. 
simplify_aux(X+Y, XS+Y):-
    compound(X), number(Y), !,
    simplify_aux(X, XS).
simplify_aux(X+Y, Y+XS):-
    compound(X), atom(Y), !,
    simplify_aux(X, XS).
simplify_aux(X, X).


% clean up till there are no paranthesis
clean_up(A, A):-
    is_clean(A).

clean_up(A, D):-
    \+ is_clean(A),
    clean(A, C),
    clean_up(C, D).
    
% remove one layer of paranethesis
clean(X+Y, A+Z):-
    compound(X),
    clean(X, A+B),
    clean(Y, YS),
    number(B),
    number(YS),
    Z is B+YS.
clean(X+Y, A+B+YS):-
    compound(X),
    clean(X, A+B),
    clean(Y, YS).
clean(X+Y, XS+A+B):-
    compound(Y),
    clean(X, XS),
    clean(Y, A+B).
clean(X+Y, X+Y):-
    atomic(X), atomic(Y).
clean(X,X):-
    atomic(X).

% check if all paranthesis are gone
is_clean(X+Y):-
    atomic(Y),
    is_clean(X).
is_clean(X):-
    atomic(X).

test:-
    simplify(c+(b+(a+1+4+2)), X),
    writeln(X).




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
