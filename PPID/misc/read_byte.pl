% readbyte.pl

read_bytes(N, String):-
    %get_byte(C),
    get_char(C),
    read_bytes_aux(C,N,String).

% end of file, so stope
read_bytes_aux(end_of_file, _, []):-
    !.

read_bytes_aux(C, 1, [C]):-
    !.

read_bytes_aux(C, N, [C|Rest]):-
    get_char(NextC),
    NextN is N - 1,
    read_bytes_aux(NextC, NextN, Rest).


% Skips the next N bytes on standard input
skip_bytes(0):-
    !.

skip_bytes(N) :-
    N > 0,
    get_char(C),
    skip_bytes_aux(C,N).

skip_bytes_aux(end_of_file, _):-
    !.

skip_bytes_aux(_, N):-
    NextN is N - 1,
    skip_bytes(Next).


demo:-
    see('absval.pl'),
    read_bytes(120, String),
    seen,
    writeln(String).
