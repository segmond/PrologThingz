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
