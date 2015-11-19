% Clam - expert system with EMYCIN type certainty factors

main:-
    do_over,
    super.

% The main command loop
super:-
    repeat,
        writeln('consult restart load list trace on/off how exit'),
        write('> '),
        read_line([X|Y]),
        doit([X|Y]),
    X == exit.

doit([consult]):-
    top_goals,
    !.

xdoit([]):-
    !.

% top_goals works through each of the goals in sequence
top_goals:-
    ghoul(Attr),
    top(Attr),
    print_goal(Attr),
    fail.
top_goals.

% top starts the backward chaining by looking for rules that reference the attribute
% in the RHS.  If it is know with certainty 100, then no other rules are tried, and
% other candiates are eliminate.  Otherwise, other rules which might yield different
% values for the attribute are tried as well.

top(Attr):-
    findgoal(av(Attr, Val), CF, [goal(Attr)]),
    !.
top(_):-
    true.

% prints all hypotheses for a given attribute
print_goal(Attr):-
    nl,
    fact(av(Attr, X), CF, _),
    CF >= 20, % Certainty Factor greater or equal than 20%
    outp(av(Attr, X), CF), 
    nl,
    fail.
print_goal(Attr):-
    write('done with '), 
    writeln(Attr),
    nl.

outp(av(A, V), CF):-
    output(A, V, PrintList),
    pretty(av(A, V), X),
    printlist(X),
    tab(1),
    write(cf(CF)),
    write(': '),
    printlist(PrintList),
    !.
outp(av(A, V), CF):-
    pretty(av(A, V), X),
    printlist(X),
    tab(1), write(cf(CF)).

printList([]).
printList([Head|Tail]):-
    write(Head), tab(1),
    printList(Tail).

% findgoal is the guts of the inference.  It copes with already know attribute/value pairs,
% multivalued attributes and single valued attributes.
% It uses the EMYCIN certainty factor arithmetic to propgate uncertainties.

% 1 - If its recorded and the value matches, we are done. If the value doesnt match,
%   but its single value and know with certainty 100 definitely fail.
findgoal(X, Y, _):-
    bugdisp([' ', X]),
    fail.
findgoal(\+ Goal, NCF, Hist):-
    findgoal(Goal, CF, Hist),
    NCF is -CF,
    !.
findgoal(Goal, CF, Hist):-
    fact(Goal, CF, _),
    !.

% 2 - if its askable, just ask and record the answer.
findgoal(Goal, CF, Hist):-
    can_ask(Goal, Hist),
    !,
    findgoal(Goal, CF, Hist).

% can_ask shows how to query the user for various types of goal patterns
can_ask(av(Attr, Val), Hist):-
    \+ asked(av(Attr, _)),
    askable(Attr, Menu, Edit, Prompt),
    query_user(Attr, Prompt, Menu, Edit, Hist),
    asserta(asked(av(Attr, _))).
