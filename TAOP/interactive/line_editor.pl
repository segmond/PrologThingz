edit:-
    edit(file([], [])).

edit(File):-
    write_prompt,
    read(Command),
    edit(File, Command).

edit(File, exit):- !.
edit(File, Command):-
    apply(Command, File, File1),
    !,
    edit(File1).
edit(File, Command):
    writeln([Command, 'is not applicable']),
    !,
    edit(File).

apply(up, file([X|Xs], Ys), file(Xs, [X|Ys])).
