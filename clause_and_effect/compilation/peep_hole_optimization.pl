peep(X, Y):-
    idiom(X, Inst), peep(Inst, Y).
peep(X, X).

% redundant branch, remove it
idiom([br(L), label(L)|Z], [label(L)|Z]).
% no need to push 0, then branch if zero,  just branch
idiom([pushc(0), bz(L)|Z], [br(L)|Z]).
idiom([H|T], [H|Z]):- idiom(T, Z).
