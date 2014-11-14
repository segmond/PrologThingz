% read file, line by line
readlineF(File, OutFile):-
	see(File),
	tell(OutFile),
	repeat,
	inputline(L),
	L=[end_of_file],
	!,
	told,
	seen.

% read file, line by line
readlineF2(File):-
	see(File),
	repeat,
	inputline(L),
	L=[end_of_file],
	!,
	seen.


% read line, building a list, list comes in reverse order so reverse it.
inputline(L):-
	buildlist(L, []),
	reverse(L,L1),
	filewriteout(L1),
	!.

% write list for display
writeout([]).
writeout([end_of_file]).
writeout(L):-
	write('Sentence: '),
	write(L),
	nl.

% write list for writing to file
filewriteout([]).
filewriteout([end_of_file]).
filewriteout(L):-
	writeq(L),
	write('.'),
	nl.


% get's one word at a time, building list until a sentence is constructed
buildlist(L, OldL):-
	findword(Word, []),
	(
	    (Word=[], L=OldL);
	    (Word=[end_of_file], L=[end_of_file]);
	    (Word=[sep], buildlist(L,OldL));
	    (Word=[term|Word1], name(S,Word1), L=[S|OldL]);
	    (name(S,Word), buildlist(L, [S|OldL]))
	).

% find a word
findword(Word, OldWord):-
	get0(X1),
	repchar(X1,X),
	(
	    (terminator(X), Word=[term|OldWord]);
	    (separator(X), ((OldWord=[], Word=[sep]); Word = OldWord));
	    (X<0, Word=[end_of_file]);
	    (append(OldWord,[X],New), findword(Word,New))
	).

% replace upper to lower
repchar(X, New):-
	X >= 65,
	X =< 90,
	New is X+32,
	!.
repchar(Char, Char).

separator(10).
separator(32).
separator(44).
separator(58).

terminator(46).
terminator(33).
terminator(63).

test:-
	readlineF('dickens.txt', 'newdickens.txt').


