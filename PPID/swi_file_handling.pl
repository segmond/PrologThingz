% file handling test


end_of_file(Fd):-
    stream_property(Fd, end_of_stream(past)),
    close(Fd).

readfile(F):-
    open(F, read, Fd, [type(text)]),
    repeat,
    get_char(Fd, Byte),
    (   at_end_of_stream(Fd)
    ->  !
    ;
        put_char(Byte),
        fail
    ).

