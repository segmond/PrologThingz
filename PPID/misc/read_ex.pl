:-ensure_loaded('read_lib.pl').

get_number(N):-
    repeat,
    write('Type a number between 1 and 3: '),
    read_num(N),
    1 =< N, N =< 3,
    !.


get_choice(C):-
    repeat,
    write('Type a, b, or c: '),
    read_atom(C),
    member(C,[a,b,c]),
    !.


get_num_or_fail(N):-
    catch(get_number(N),_,fail).


get_num_never_fail(N):-
    catch(get_number(N),_,get_num_never_fail(N)).

