% code generation for stack machine
cg(I, pushc(I)):-
    integer(I).

cg(A, push(A)):-
    atom(A).
