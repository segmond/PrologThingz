% file handling test

close_files(Src, Dst):-
    close(Src),
    close(Dst).

cpfile(Src, Dst):-
    open(Src, read, In, [type(binary)]),
    open(Dst, write, Out, [type(binary), lock(write)]),
    repeat,
    get_byte(In, Byte),
    (   at_end_of_stream(In)
    ->  close_files(In, Out)
        ; put_char(Out, Byte),
        fail
    ).

