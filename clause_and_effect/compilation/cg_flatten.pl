% code generator
% exercises 9.1.1

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

% Multiple (MUL ra, rb) Multiple the contents of registers ra and rb,
% setting register rb to the result.
cg(X*Y, R, C0-C2):-
	cg(X, R, C0-C1),
	R1 is R + 1,
	cg(Y, R1, C1-[mul(r(R1),r(R))|C2]).


% Store Memory (STM r, x) Set the contents of memory location x to the
% contents of register r
cg(assign(X, Y), R, C0-C2):-
	cg(Y, R, C0-C1),
	C1 = [stm(r(R),X)|C2].

% While loop (LabelN, code to test X, branch to LabelM if test fails,
% Code for Y, Branch LabelN, LabelM)
% CX is code to test X, branching to label(R2) if test fails
% CX is code for Y
cg(while(X, Y), R, C0-C4):-
	C0-C1=[label(R1)|C1]-C1,
	ct(X, R, C1-C2, R2),
	cg(Y, R, C2-C3),
	C3 = [br(R1), label(R2)|C4].

% generate codes for statements separated by comma
cg((A; B), R, C0-C2):-
	cg(A, R, C0-C1),
	cg(B, R, C1-C2).

% if(x, y) - If X then Y
% code to test X, branch to LabelN if test fails, Code For Y, LabelN
cg(if(X, Y), R, C1-C3):-
    ct(X, R, C1-C2, R1),
    cg(Y, R, C2-[label(R1)|C3]).

% if(x, y, z) - If X then Y else Z
%     Code to test X, branch to Lm if test fails
%     Code For Y
%     BR Ln
% Lm
%     Code For Z
% Ln
cg(if(X, Y, Z), R, C1-C4):-
    ct(X, R, C1-C2, R1),
    cg(Y, R, C2-[br(R2), label(R1)|C3]),
    cg(Z, R, C3-[label(R2)|C4]).



% compare (CMP ra rb) Compare the contents of registers ra and rb,
% setting the rcondition bits accordingly.
%
% branch if greater than or equal (BGE x) If condition bit N (Negative)
% equals condition bit V (Overflow), then go to the location specified
% by label x
ct(X < Y, R, C0-C2, R):-
	cg(X, R, C0-C1),
	R1 is R + 1,
	cg(Y, R1, C1-[cmp(R,R1), bge(R)|C2]).



/*
	c := 1;
	r := 1;
	while c < n do
	     (c := c + 1;
	      r := r * c)
*/
program(1, (
    assign(c,1);
    assign(r,1);
    while((c < n),
	  (assign(c, c+1);
           assign(r, r*c))))).
/*
	if (c < n ) then
	    (c := c + 1);
	z := 10
*/
program(2, (
    if((c < n),
       (assign(c, c+1)));
    assign(z, 10))).

/*
	if (c < n) then
	    (c := c + 1)
	else
	    (d := d + 2);
	z := 10
*/
program(3, (
    if((c < n),
       (assign(c, c+1)), (assign(d, d+2)));
    assign(z, 10))).



% testcg1(1+2+3, R).
testcg1(Expr, C):-
	cg(Expr, 1, C).

testcg2(Code):-
	program(1,Prog),
	cg(Prog, 1, Code-[]),
	print_code(Code).

print_code([]).
print_code([H|T]):-
	writeln(H),
	print_code(T).

compile(N):-
	program(N, Program),
	cg(Program, 1, AsmCode-[]),
	print_code(AsmCode).
