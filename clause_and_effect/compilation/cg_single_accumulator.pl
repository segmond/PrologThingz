% Code generation for single accumlator machine

% Store an Integer in the accumlator
cg(I, _, [lda(c(I))]):-
	integer(I).

% Store an atom in the accumlator
cg(A, _, [lda(A)]):-
	atom(A).

%  Add an Expression and (Identifier or Constant)
cg(X+A, T, [CX, add(A)]):-
	atom(A),
	cg(X, T, CX).

%  Add an Expression and Integer
cg(X+I, T, [CX, add(c(I))]):-
	integer(I),
	cg(X, T, CX).

%  Add an Expression and Expression
cg(X+Y, T, [CX, sta(t(T)), CY, add(t(T))]):-
	cg(X, T, CX),
	T1 is T + 1,
	cg(Y, T1, CY).

%  Multiple an Expression and (Identifier or Constant)
cg(X*A, T, [CX, mul(A)]):-
	atom(A),
	cg(X, T, CX).

%  Multiple an Expression and Integer
cg(X*I, T, [CX, mul(c(I))]):-
	integer(I),
	cg(X, T, CX).

%  Multiple an Expression and Expression
cg(X*Y, T, [CX, sta(t(T)), CY, mul(t(T))]):-
	cg(X, T, CX),
	T1 is T + 1,
	cg(Y, T1, CY).

cg(while(X, S), T, [label(L1), CX, SX, br(L1), label(L2)]):-
	ct(X, T, CX, L2),
	cg(S, T, SX).

cg((A; B), T, [CA, CB]):-
	cg(A, T, CA),
	cg(B, T, CB).

cg(assign(A,X), T, [CX, sta(A)]):-
	cg(X, T, CX).

ct(X<A, T, [CX, cmp(A), bge(R)], R):-
	atom(A),
	cg(X, T, CX).

ct(X<Y, T, [CY, sta(t(T)), CX, cmp(t(T)), bge(L)], L):-
	cg(Y, T, CY),
	T1 is T + 1,
	cg(X, T1, CX).



flatten_code([], Z-Z).
flatten_code([H|T], HF-TFE):-
	flatten_code(H, HF-Mid),
	flatten_code(T, Mid-TFE).
flatten_code(E, [E|Z]-Z).

print_code([]).
print_code([H|T]):-
	writeln(H),
	print_code(T).

compile(N):-
	program(N, Program),
	cg(Program, 1, AsmCode-[]),
	print_code(AsmCode).
test1:-
	cg(while((c < n), (assign(z, 2 + 7); assign(y, 3))), 1, X),
	flatten_code(X, Y-[]),
	print_code(Y).







