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
    read_string(Input, "\n", "\r", _, S).

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
    requestanswer(Anslist, Maxscore),
    fail.

askq:-
    myscore(M, Maxtotal),
    format("Your total score is ~w points out of a possible ~w~n", [M, Maxtotal]),
    range(First, Last, Feedback),
    M >= First,
    M =< Last,
    format("~w~n~n~n", [Feedback]).

genanswers([ans(A,_)]):-
    format('and ~w~n', [A]),
    !.

genanswers([ans(A,_)|T]):-
    format('~w, ', [A]),
    genanswers(T).

requestanswer(Anslist, Maxscore):-
    writeln('Enter your answer'),
    readline(Answer),
    (
        member(ans(Answer,Score), Anslist), usescore(Score, Maxscore), 
        !
    ;
        format("That is not a valid answer - try again!~n"),
        requestanswer(Anslist, Maxscore)
    ).

usescore(Score, Maxscore):-
    format("You have scored  ~w points out of a possible ~w~n~n", [Score, Maxscore]),
    retract(myscore(Old, Oldtotal)),
    New is Old+Score,
    Newtotal is Oldtotal+Maxscore,
    assertz(myscore(New, Newtotal)).
