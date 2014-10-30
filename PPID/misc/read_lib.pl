:-ensure_loaded('read_string.pl').
:-ensure_loaded('read_byte.pl').

% read_atom(-Atom)
%   Reads a line of input and converts it to an atom.
read_atom(Atom):-
    read_str_aux1(String),
    atom_codes(Atom,String).

% read_num(-Number)
%   Reads a line of input and converts it to a number.
read_num(Atom):-
    read_str_aux1(String),
    number_codes(Atom,String).

% write_str(+String)
%   Outputs the characters corresponding to a list of ASCII codes.
write_str([Code|Rest]):-
    put(Code),
    write_str(Rest).
write_str([]).

strcodes_to_lower([], []).

strcodes_to_lower([Char|T], [NewChar|R]):-
    Char >= 65, Char =< 90,
    NewChar is Char + 32,
    strcodes_to_lower(T, R).

strcodes_to_lower([Char|T], [Char|R]):-
    strcodes_to_lower(T, R).


%ex5.2.5
% read_lc_atom(-Atom)
%   Reads a line of input and converts it to an atom/lower case.
read_lc_atom(Atom):-
    read_str_aux1(String),
    strcodes_to_lower(String, LowerString),
    atom_codes(Atom,LowerString).

%ex5.2.6
% hex to decimal
hex_to_dec(H,D):-
    H >= 48, H =< 57, D is H - 48.
hex_to_dec(H,D):-
    H >= 65, H =< 70, D is H - 55.
hex_to_dec(H,D):-
    H >= 97, H =< 102, D is H - 87.


% read_hex_num(-Number)
%   Reads a line of input and converts it to a hex number.
read_hex_num(Atom):-
    read_str_aux1(String),
    strcodes_to_hex(String, Atom).


% convert codes to hex
strcodes_to_hex([H|T], HexString):-
    strcodes_to_hex_aux([H|T], 0, HexString).

strcodes_to_hex_aux([], M, M).

strcodes_to_hex_aux([H|T], M, HexString):-
    hex_to_dec(H,D),
    NewM is (M * 16) + D,
    strcodes_to_hex_aux(T, NewM, HexString).

strcodes_to_hex_aux([46|_],M,M). % terminate on Return char


% Menu Routines

get_nth_menu_item(Menu,Num,What):-
    nth1(Num,Menu,item(_,What)).


get_number_to(Limit,N):-
    repeat,
    format('Type a number between 1 and ~w: ~n', [Limit]),
    read_num(N),
    1 =< N, N =< Limit,
    !.


% print_menu(+Menu, -Size) - prints menu and returns the size
print_menu(Menu,Size):-
    print_menu(Menu, 0, Size).

print_menu([],Size,Size).

print_menu([item(H,_)|T], N, Size):-
    NewN is N + 1,
    format('~w ~w~n', [NewN, H]),
    print_menu(T, NewN, Size).


menu_choose(Menu, MenuSize, What):-
    get_number_to(MenuSize, Num),
    get_nth_menu_item(Menu, Num, What).

menu(Menu, What):-
    print_menu(Menu, MenuSize),
    menu_choose(Menu, MenuSize, What).


test_menu(What):-
    menu([item('Georgia','ga'),item('Florida','fl'),item('Hawaii','hi')],What).
