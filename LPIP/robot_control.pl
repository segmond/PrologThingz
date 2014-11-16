% read in sequence of lines one at a time and write them out again until
% a line containg just STOP is input as follows.

go:-
	repeat,
	inputline([], L),
	name(S, L),
	write('S='),
	writeln(S),
	S =  'STOP',
	writeln('FINISHED').

inputline(OldL, L):-
	get0(X),
	process(X, OldL, L).

process(10, L, L).
process(X, OldL, NewL):-
	X =\= 10,
	append(OldL, [X], L2),
	inputline(L2, NewL).


