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

% 3 - find a rule with the required attribute on the RHS.  Try to prove the LHS.
%   If its proved, use the certainty of the LHS combined with the certainty of the RHS
%   to compute the CF of the derived result.
findgoal(Goal, CF, Hist):-
    fg(Goal, CF, Hist).

% use a repeat fail loop to continue to find rules whose RHS conclude a value for the attribtue.
% The process stops when the attribute is known with a certainty factor of 100 or all the 
% rules have been tried.
fg(Goal, CurrentCF):-
    rule(Next, lhs(IfList), rhs(Goal, CF)),
    prove(IfList, Tally),   % prove the LHS premise and find its CF
    adjust(CF, Tally, NewCF),   % combine the LHS CF with the RHS CF
    update(Goal, NewCF, CurrentCF), % update existing working storage values with the new conclusion
    CurrentCF == 100,
    !.  
fg(Goal, CurrentCF):-
    fact(Goal, CurrentCF).

adjust(CF1, CF2, NewCF):-
    X is CF1 * CF2 / 100,
    int_round(X, NewCF).

int_round(X, I):-
    X >= 0,
    I is integer(X + 0.5).
int_round(X, I):-
    X < 0,
    I is integer(X - 0.5).

% can_ask shows how to query the user for various types of goal patterns
can_ask(av(Attr, Val), Hist):-
    \+ asked(av(Attr, _)),
    askable(Attr, Menu, Edit, Prompt),
    query_user(Attr, Prompt, Menu, Edit, Hist),
    asserta(asked(av(Attr, _))).

% get input from the user.  Either a straight ansewr from the menu or an answer with cf N appended to it.
query_user(Attr, Prompt, [yes,no], _, Hist):-
    !, 
    writeln(Prompt),
    get_user(X, Hist),
    get_vcf(X, Val, CF),
    asserta(fact(av(Attr, Val), CF, [user])).
query_user(Attr, Prompt, Menu, Edit, Hist):-
    writeln(Prompt),
    menu_read(VList, Menu, Hist),
    assert_list(Attr, VList).

menu_read(X, Menu, Hist):-
    write_list(2, Menu),
    get_user(X, Hist).

% write a list seperated by new line for menu
write_list(Spacing, []).
write_list(Spacing, [Head|Tail]):-
    tab(Spacing),
    writeln(Head),
    write_list(Spacing, Tail).

get_user(X, Hist):-
    repeat,
        write(': '),
        read_line(X),
    process_ans(X, Hist).

process_ans([why], Hist):-
    nl,
    write_hist(Hist),
    !,
    fail.
process_ans(X,_).

write_hist([]):- nl.
write_hist([goal(X) | Tail]):-
    write_line([goal, X]),
    !,
    write_hist(Tail).
write_hist([Next | Tail]):-
    list_rule(Next),
    !,
    write_hist(Tail).

% get value certainty factor
get_vcf([no], yes, -100).
get_vcf([no, CF], yes, NewCF):-
    NewCF is - CF.
get_vcf([no, cf, CF], yes, NewCF):-
    NewCF is - CF.
get_vcf([Val, CF], Val, CF).
get_vcf([Val,cf, CF], Val, CF).
get_vcf([Val], Val, 100).
get_vcf([not, Val], Val, -100).
get_vcf([not, Val, CF], Val, NewCF):-
    NewCF is - CF.
get_vcf([not, Val, cf, CF], Val, NewCF):-
    NewCF is - CF.
