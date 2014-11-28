% merge(+List1, +List2, -Result)
%   Combines two sorted lists into a sorted list.


merge([H1|T1], [H2|T2], [H1|Res]):-
    H1 @< H2,
    !,
    merge(T1, [H2|T2], Res).

merge([H1|T1], [H2|T2], [H2|Res]):-
    !,
    merge([H1|T1], T2, Res).

merge(X,[],X).
merge([],X,X).

% msort(+List1, -List2)
%   Sorts List1 giving List2 using mergesort.

msort([X,Y|Z], Res):-
    !,
    partition([X,Y|Z], L1, L2),
    msort(L1,SL1),
    msort(L2,SL2),
    merge(SL1,SL2, Res).

msort(L, L).

% partition(+List, -List1, -List2)
%   splits List in two th ee simplest way by putting alternate members in different lists

partition([A,B|Rest], [A|L1], [B|L2]):-
    !,
    partition(Rest, L1, L2).
partition(L,L,[]).
