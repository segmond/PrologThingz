% read_str(String)
%   Accepts a whole line of input as a string
%   Assumes the keyboard is buffered.

read_str(String) :-
    read_str_aux1(S), 
    name(String, S).

read_str_aux1(String) :-
    get0(Char),
    read_str_aux2(Char,String).

read_str_aux2(-1,[]) :- !.   % end of file
read_str_aux2(10,[]) :- !.   % end of file (UNIX)
read_str_aux2(13,[]) :- !.   % end of file (DOS)

read_str_aux2(Char, [Char|Rest]) :-
    read_str_aux1(Rest).

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

%ex5.2.5
% read_atom(-Atom)
%   Reads a line of input and converts it to an atom/lower case.
strcodes_to_lower([], []).
strcodes_to_lower([Char|T], [NewChar|R]):-
    Char >= 65, Char =< 90,
    NewChar is Char + 32,
    strcodes_to_lower(T, R).
strcodes_to_lower([Char|T], [Char|R]):-
    strcodes_to_lower(T, R).
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
% read_num(-Number)
%   Reads a line of input and converts it to a number.
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

