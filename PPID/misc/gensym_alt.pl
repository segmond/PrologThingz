% gensym(Var)
%   generates a new itme everytime it's called
%   rewrote the if then else clause in prodecural style
:- dynamic(gensym_aux/2).

gensym(X):-
    retract(gensym_aux(C,Gen)),
    C1 is C+1,
    has_seen_z(C1,Gen,Gen1),
    char_code(Char,C),
    string_concat(Gen,Char,X).
gensym_aux(97,"").

has_seen_z(123,Gen,Gen1):-
    !,
    string_concat(Gen,"z",Gen1),
    asserta(gensym_aux(97,Gen1)).
has_seen_z(X,Gen,Gen1):-
    string_concat(Gen,"",Gen1),
    asserta(gensym_aux(X,Gen1)).


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
