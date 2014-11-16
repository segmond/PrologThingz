setup:-
	see('quiz1.txt'),
	readin,
	seen,
	writeln('Setup completed').

readin:-
	read(Title),
	assertz(title(Title)),
	readqs.

readqs:-
	repeat,
	read(Qtext),
	process(Qtext),
	Qtext = endquestions,
	readranges.

process(endquestions):- !.
process(Qtext):-
	procqs([], Anslist, -9999, Maxscore),
	assertz(question(Qtext, Anslist, Maxscore)).

procqs(Anscurrent, Anslist, Maxsofar, Maxscore):-
	read(Ans),
	(
	    (Ans=end, Anslist=Anscurrent, Maxscore=Maxsofar, !)
	    ;
	    (
		read(Score),
		append(Anscurrent, [ans(Ans, Score)], Ansnew),
		Maxnew is max(Maxsofar, Score),
		procqs(Ansnew, Anslist, Maxnew, Maxscore)
	    )
	).

readranges:-
	repeat,
	read(First),
	process_answers(First),
	First = endmarkscheme.

process_answers(endmarkscheme):- !.
process_answers(First):-
	read(Last),
	read(Feedback),
	assertz(range(First, Last, Feedback)).

readline(S):-
    readline_aux([], L),
    name(S, L),
    !.
readline_aux(Lcurrent, Lfinal):-
    get0(X),
    (
        (X=10, Lfinal=Lcurrent);
        (append(Lcurrent, [X], Lnew), readline_aux(Lnew, Lfinal))
    ).

read_string_line(S):-
    current_input(Input),
    read_string(Input, "\n", "\r", End, S).

runquiz:-
    retractall(myscore(_,_)),
    assertz(myscore(0,0)),
    title(T),
    format('~w ~n~n', [T]),
    askq.

askq:-
    question(Qtext, Anslist, Maxscore),
    writeln(Qtext),
    write('Possible answers are '),
    genanswers(Anslist),
    fail.

askq:-
    foo,
    .

genanswers([ans(A,_)]):-
    format('and ~w~n', [A]),
    !.

genanswers([ans(A,_)|T]):-
    format('~w, ', [A]),
    genanswers(T).
