% yes or no
get_yes_or_no(Res) :-
    get_single_char(Code),
    interpret(Code, Res),
    !.

get_yes_or_no(Res) :-
    nl,
    write('Type Y or N:'),
    get_yes_or_no(Res).

interpret(89, yes).     % Y
interpret(121, yes).    % y
interpret(78, no).      % N
interpret(110, no).     % n
