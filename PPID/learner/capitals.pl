capital_of(georgia,atlanta).
capital_of(california,sacramento).
capital_of(florida,tallahassee).
capital_of(maine,augusta).

print_a_capital:-
    capital_of(State, City),
    write(City),
    write(' is the capital of '),
    write(State),
    nl.

print_capitals:-
    print_a_capital,
    fail.
