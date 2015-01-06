echo:-
    read(X), echo(X).

echo(X):-
    last_input(X), !.

echo(X):-
    writeln(X), read(Y), !, echo(Y).

last_input(X):-
    X = stop.
