% code generator

% Move Constant (MOVC x, r) Set register r to the constant x.
cg(I, R, [movc(I, r(R))|Z]-Z):-
	integer(I).

% Move Memory (MOVM x, r) Set register r to the contents of the memory
% location x
cg(A, R, [movm(A, r(R))|Z]-Z):-
	atom(A).

% Add (ADD ra, rb) Add the contents of registers ra and rb, setting
% register rb to the result.
cg(X+Y, R, C0-C2):-
	cg(X, R, C0-C1),
	R1 is R + 1,
	cg(Y, R1, C1-[add(r(R1),r(R))|C2]).

% testcg1(1+2+3, R).
testcg1(Expr, C):-
	cg(Expr, 1, C).
