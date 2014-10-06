% gensym(Var)
%   generates a new itme everytime it's called

:- dynamic(gensym_aux/2).

gensym(X):-
    retract(gensym_aux(C,Gen)),
    C1 is C+1,
    (   C1 == 123 
    -> 
        string_concat(Gen,"z",Gen1),
        asserta(gensym_aux(97,Gen1))
    ;
        string_concat(Gen,"",Gen1),
        asserta(gensym_aux(C1,Gen1))
    ),
    char_code(Char,C),
    string_concat(Gen,Char,X).
gensym_aux(97,"").


for(N,Goal):-
    for_aux(0, N, Goal).

for_aux(C,N,Goal) :-
    C1 is C+1,
    C < N,
    call(Goal),
    for_aux(C1,N,Goal).


test_gensym :-
    gensym(X),
    writeln(X).


test :-
    for(78, test_gensym).
