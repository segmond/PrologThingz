% read in sequence of lines one at a time and write them out again until
% a line containg just STOP is input as follows.

control_robot:-
	repeat,
	inputline(L),
	L =  [stop],
	writeout(L),
	!.

inputline(L):-
	buildlist(L, []),
	reverse(L, L1),
	writeout(L1),
	!.

writeout([]).
writeout(L):-
	writeq(L),
	nl.

buildlist(L, OldL):-
	findword(Word, []),
	(
	    (Word=[], L=OldL);
	    (Word=[sep], buildlist(L, OldL));
	    (Word=[terminator|Word1], name(S, Word1), L=[S|OldL]);
	    (name(S,Word), buildlist(L, [S|OldL]))
	).

findword(Word, OldWord):-
	get0(X1),
	repchar(X1, X),
	(
	    (terminator(X), Word=[terminator|OldWord]);
	    (separator(X), ((OldWord=[], Word=[sep]); Word = OldWord));
	    (append(OldWord, [X], New), findword(Word, New))
	).

separator(32).    % separator

terminator(10).   % end of line

repchar(X, New):-
	X >= 65, X =< 90, New is X + 32, !.
repchar(Char, Char).

