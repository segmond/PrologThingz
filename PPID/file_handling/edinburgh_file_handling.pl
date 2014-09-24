% file handling test


end_of_file(end_of_file, F):-
    seen.

writeline(end_of_file).
writeline(Line):-
    write(Line), nl.
readfile(F):-
    see(F),
    repeat,
    read(Line),
    writeline(Line),
    end_of_file(Line, F).
