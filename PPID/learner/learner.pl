% program that modifies it's own knowledge base
% program requires the knowledge base capitals.pl

start :-
    reconsult('capitals.pl'),
    nl,
    write('Type names entirey in lower case, followed by period.'), nl,
    write('Type "stop." to quit.'), nl, nl,
    process_a_query.

process_a_query:-
    write('State? '),
    read(State),
    answer(State).

% if user typed "stop." then save the KB and quit
answer(stop):-
    write('Saving the knowledge base...'), nl,
    tell('capitals.pl'),
    %write(':- dynamic(capital_of/2).'), nl,
    listing(capital_of),
    told,
    write('Done.'),nl.

% if state is in knowledge base, display it then loop
answer(State):-
    capital_of(State, City),
    write('The capital of '),
    write(State),
    write(' is '),
    write(City), nl, nl,
    process_a_query.

% if state is not in the knowledge base, ask for it, save it to the KB and loop
answer(State):-
    \+ capital_of(State, _),
    write("I don't know the capital of that state."), nl,
    write('Please tell me.'), nl,
    write('Capital? '),
    read(Capital),
    write('Thank you.'), nl, nl,
    assertz(capital_of(State, Capital)),
    process_a_query.
