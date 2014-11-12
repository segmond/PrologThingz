% code generation for stack machine
cg(I, pushc(I)):-
    integer(I).

cg(A, push(A)):-
    atom(A).

cg(X+Y, [CX, CY, add]):-
    cg(X, CX),
    cg(Y, CY).

cg(X*Y, [CX, CY, mul]):-
    cg(X, CX),
    cg(Y, CY).

cg(X<Y, [CX, CY, clt]):-
    cg(X, CX),
    cg(Y, CY).

cg(assign(X,Y), [CY, pop(X)]):-
    cg(Y, CY).

cg(while(X, S), [label(R1), CX, bz(R2), SX, br(R1), label(R2)]):-
    cg(X, CX),
    cg(S, SX).

cg((A;B), [CA, CB]):-
    cg(A, CA),
    cg(B, CB).

cg(if(X, Y), [CX, bz(R2), CY, label(R2)]):-
    cg(X, CX),
    cg(Y, CY).
