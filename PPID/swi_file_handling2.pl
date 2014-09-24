% file handling test

close_files(Src, Dst):-
    close(Src),
    close(Dst).

cpfile(Src, Dst):-
    open(Src, read, In, [type(text)]),
    open(Dst, write, Out, [type(text), lock(write)]),
    repeat,
    get_char(In, Byte),
    (   at_end_of_stream(In)
    ->  close_files(In, Out)
        ; put_char(Out, Byte),
        fail
    ).

