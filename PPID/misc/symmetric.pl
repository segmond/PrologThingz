% inference engine for bi conditionals in prolog
:-op(850, fx, symmetric).

symmetric(Def):-
    Def=..[Fun, A1, A2],
    Def2=..[Fun, A2, A1],
    asserta(Def),
    asserta(Def2).

test(X,Y):-
    symmetric married(john, mary),
    married(X,Y).

