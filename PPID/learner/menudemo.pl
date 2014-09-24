% program that modifies it's own knowledge base
% program requires the knowledge base capitals.pl

:-include('capitals.pl').

start:-
    display_menu,
    get_from_menu(State),
    capital_of(State, City),
    format('~n ~w ~w ~w ~w ~N', ['The capital of', State, 'is', City]).

display_menu:-
    format('Which state do you want to know about?~n'),
    format(' 1 Georgia~n'),
    format(' 2 California~n'),
    format(' 3 Florida~n'),
    format(' 4 Maine~n'),
    format('Type a number, 1 to 4 -> ').


interpret(49,georgia). % ASCII 49 = '1'
interpret(50,california).
interpret(51,florida).
interpret(52,maine).

get_from_menu(State):-
    get_single_char(Code),
    interpret(Code, State).

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
