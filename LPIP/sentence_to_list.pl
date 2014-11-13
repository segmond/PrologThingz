readlineF(File):-
	see(File),
	repeat,
	inputline(L),
	L=[end_of_file],
	!,
	seen.

inputline(L):-
	buildlist(L, []),
	reverse(L,L1),
	writeout(L1),
	!.

writeout([]).
writeout([end_of_file]).
writeout(L):-
	write('Sentence: '),
	write(L),
	nl.

buildlist(L, OldL):-
	findword(Word, []),
	(
	    (Word=[], L=OldL);
	    (Word=[end_of_file], L=[end_of_file]);
	    (Word=[sep], buildlist(L,OldL));
	    (Word=[term|Word1], name(S,Word1), L=[S|OldL]);
	    (name(S,Word), buildlist(L, [S|OldL]))
	).

findword(Word, OldWord):-
	get0(X),
	(
	    (terminator(X), Word=[term|OldWord]);
	    (separator(X), ((OldWord=[], Word=[sep]); Word = OldWord));
	    (X<0, Word=[end_of_file]);
	    (append(OldWord,[X],New), findword(Word,New))
	).

separator(10).
separator(32).
separator(44).
separator(58).

terminator(46).
terminator(33).
terminator(63).

test:-
	readlineF('dickens.txt').


