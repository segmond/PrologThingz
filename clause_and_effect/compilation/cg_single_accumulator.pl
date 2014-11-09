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
