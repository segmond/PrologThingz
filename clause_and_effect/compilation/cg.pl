% code generator

% Move Constant (MOVC x, r) Set register r to the constant x.
cg(I, R, [movc(I, r(R))]):-
	integer(I).

% Move Memory (MOVM x, r) Set register r to the contents of the memory
% location x
cg(A, R, [movm(A, r(R))]):-
	atom(A).

% Add (ADD ra, rb) Add the contents of registers ra and rb, setting
% register rb to the result.
cg(X+Y, R, [CX, CY, add(r(R1), r(R))]):-
	cg(X, R, CX),
	R1 is R + 1,
	cg(Y, R1, CY).

% Multiple (MUL ra, rb) Multiple the contents of registers ra and rb,
% setting register rb to the result.
cg(X*Y, R, [CX, CY, mul(r(R1), r(R))]):-
	cg(X, R, CX),
	R1 is R + 1,
	cg(Y, R1, CY).

% Store Memory (STM r, x) Set the contents of memory location x to the
% contents of register r
cg(assign(X, Y), R, [CY, stm(r(R), X)]):-
	cg(Y, R, CY).

% While loop (LabelN, code to test X, branch to LabelM if test fails,
% Code for Y, Branch LabelN, LabelM)
% CX is code to test X, branching to label(R2) if test fails
% CX is code for Y
cg(while(X, Y), R, [label(R1), CX, CY, br(R1), label(R2)]):-
	ct(X, R, CX, R2),
	cg(Y, R, CY).

% generate codes for statements separated by comma
cg((A; B), R, [CA, CB]):-
	cg(A, R, CA),
	cg(B, R, CB).

% compare (CMP ra rb) Compare the contents of registers ra and rb,
% setting the rcondition bits accordingly.
%
% branch if greater than or equal (BGE x) If condition bit N (Negative)
% equals condition bit V (Overflow), then go to the location specified
% by label x
ct(X < Y, R, [CX, CY, cmp(R, R1), bge(R)], R):-
	cg(X, R, CX),
	R1 is R + 1,
	cg(Y, R1, CY).

/*
	c := 1;
	r := 1;
	while c < n do
	     (c := c + 1;
	      r := r * c)
*/
program((
    assign(c,1);
    assign(r,1);
    while((c < n),
	  (assign(c, c+1);
	  assign(r, r*c))))).


% testcg1(1+2+3, R).
testcg1(Expr, C):-
	cg(Expr, 1, C).

testcg2(Code):-
	program(Prog),
	cg(Prog, 1, Code).
