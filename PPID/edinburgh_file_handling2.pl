% file handling test


end_of_file(end_of_file):-
    seen, told.

writeline(end_of_file).
writeline(Line):-
    write(Line), nl.

cpfile(S, D):-
    see(S),
    tell(D),
    repeat,
    read(Line),
    writeline(Line),
    end_of_file(Line).
