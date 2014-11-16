% read in sequence of lines one at a time and write them out again until
% a line containing just STOP is input as follows.

control_robot:-
	initialise,
	repeat,
	inputline(L),
	L =  [stop],
	!.

inputline(L):-
	buildlist(L, []),
	reverse(L, L1),
	writeout(L1),
	!.

writeout([]).
writeout(L):-
	(   (verify(L),
	     X =.. L,
	     writeln(X),
	     call(X)
	    )
	    ;
	    (writeln("Invalid input"))
	).

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


initialise:-
	retractall(orientation(_)),
	retractall(position(_,_)),
	assertz(position(0,0)),   % zero meters North, and zero meters East
	assertz(orientation(90)). % degrees anticlose form East


% verify that the command is valid
verify([H|_]):-
	member(H, [forward, back, turn, goto, face, report, stop]).

% robot commands
stop:-
	writeln("End of Input").

turn(right):-
	turn(90, degrees, clockwise).
turn(left):-
	turn(90, degrees, anticlockwise).
turn(round):-
	turn(180, degrees, anticlockwise).
turn(N, degrees, clockwise):-
	N1 is -1 * N,
	turn(N1, degrees, anticlockwise).
turn(N, degrees, anticlockwise):-
	retract(orientation(Current)),
	New is (Current+N) mod 360,
	assertz(orientation(New)),
	format("** New orientation is ~w degreees anticlockwise from East~n", [New]).

face(N, degrees):-
	retract(orientation(_)),
	assertz(orientation(N)),
	format("** New orientation is ~w degreees anticlockwise from East~n", [N]).

report:-
	position(North, East),
	round2dp(North, North1),
	round2dp(East, East1),
	format("** Position is ~w meters North and ~w meters East~n", [North1, East1]),
	orientation(N),
	format("** Orientation is ~w degreees anticlockwise from East~n", [N]).

round2dp(X, Y):-
	Y is round(X*100) / 100.







