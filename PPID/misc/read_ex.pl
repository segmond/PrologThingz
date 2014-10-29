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

print_menu(Menu,Size):-
    print_menu(Menu, 0, Size).
print_menu([],Size,Size).
print_menu([item(H,_)|T], N, Size):-
    NewN is N+1,
    format('~w ~w~n', [NewN,H]),
    print_menu(T, NewN, Size).

menu(Menu,What):-
    print_menu(Menu, MenuSize),
    get_number_to(MenuSize,Num),
    get_nth_menu_item(Menu,Num,What).
get_nth_menu_item(Menu,Num,What):-
    nth1(Num,Menu,item(_,What)).
get_number_to(Limit,N):-
    repeat,
    format('Type a number between 1 and ~w: ~n', [Limit]),
    read_num(N),
    1 =< N, N =< Limit,
    !.

test_menu(What):-
    menu([item('Georgia','ga'),item('Florida','fl'),item('Hawaii','hi')],What).
