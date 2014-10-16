% ex 3.1
% delete last N elements off L
del_lastN(L,N,X):-
    length(Y,N),
    append(X,Y,L).

% ex 3.2
% add to end of list
last(E, [], [E]).
last(E,[H|T], [H|X]):-
    last(E,T,X).

% prefix
gprefix([],_).
gprefix([H|T],[H|Y]):-
    gprefix(T,Y).

% use prefix
gsublist(S,L):-
    gprefix(S,L).
gsublist(S,[H|T]):-
    gsublist(S,T).
    
% book definition
sublist(S,L):-
    append(L1,L2,L),
    append(S,L3,L2).

% ex 3.3
evenlength([]).
evenlength([A,B|T]):-
    evenlength(T).

oddlength([H|T]):-
    evenlength(T).

% ex 3.4
xreverse([],[]).
xreverse([H|T],R):-
    xreverse(T,RR),
    append(RR,[H],R).


equal_list([],[]).
equal_list([H|T],[H|Y]):-
    equal_list(T,Y).

%ex 3.5
palindrome(L):-
    xreverse(L, RL),
    equal_list(L,RL).

%ex 3.6
shift([H|T],R):-
    append(T,[H],R).

%ex 3.7
means(0,zero). means(1,one). means(2,two). means(3,three). means(4,four). means(5,five).
means(6,six). means(7,seven). means(8,eight). means(9,nine).

translate([],[]).
translate([H|T], [X|Y]):-
    means(H,X),
    translate(T,Y).

%ex 3.8
% broken FIXME
xsubset([], _).
xsubset([H|T],S):-
    member(H,S),
    xsubset(T,S).
% a bit better, but still broken
wsubset(_,[]).
wsubset(S,[H|T]):-
    wsubset(S,T),
    member(H,S).

% better - from stackoverflow
vvappend([],L,L).
vvappend([H|T],L,[H|L1]):-
    vvappend(T,L,L1).
vvsubset([X|T],[X|L]):-
    vvsubset(T,L).
vvsubset([X|T],[G|L]) :-
    vvsubset([X],L),
    vvappend(L2,[X|L3],[G|L]),
    vvappend(L2,L3,L4),
    vvsubset(T,L4).
vvsubset([],_).

%ex 3.9
dividelist([],[],[]).
dividelist([A],[A],[]).
dividelist([A,B|T], [A|L1], [B|L2]):-
    dividelist(T,L1,L2). 

%ex 3.10
equal_length([],[]).
equal_length([A|B],[X|Y]):-
    equal_length(B,Y).
equal_length([H|B],[H|Y]):-
    equal_length(B,Y).

%ex 3.11
xflatten([],[]).
xflatten([H|T],Flat):-
    xflatten(H,HF),
    xflatten(T,TF),
    append(HF,TF,Flat).
xflatten(E,[E]).

:-op(300,xfx,plays).
:-op(200,xfy,and).
% T = jimmy plays football and squash, display(T).
% T = susan plays tennis and basketball and volleyball, display(T)

%ex 3.13
:-op(200,fy,the).
:-op(300,xfx,of).
:-op(400,xfy,was).
% T = diana was the secretary of the department, T = Who was the secretary of the department.
%- T = diana was the secretary of the department, T = diana was What.


max(X,Y,Max):-
    X >= Y,
    Max = X.
max(X,Y,Max):-
    Y > X,
    Max = Y.

%ex 3.17
maxlist([H], H).
maxlist([H|T],R):-
    maxlist_aux([H|T],H,R).
maxlist_aux([],A,A).
maxlist_aux([A|B], CurrMax,Max):-
    max(CurrMax,A,Max2),
    maxlist_aux(B,Max2,Max).
    

%ex 3.19
ordered([]).
ordered([E]).
ordered([H|T]):-
    ordered_aux([H|T], H).
ordered_aux([H|T], Cmp):-
    H >= Cmp,
    ordered_aux(T,H).
ordered_aux([],_).


%ex 3.20
sumlist(L,R):-
    sumlist(L,0,R).
sumlist([],Acc,Acc).
sumlist([H|T], Acc, R):-
    NewAcc is H + Acc,
    sumlist(T,NewAcc,R).
subsum(Set, Sum, SubSet):-
    vvsubset(SubSet,Set),
    sumlist(SubSet, Sum).

%ex3.21
mybetween(N1,N2,X):-
    N2 - N1 > 1,
    X is N1 + 1.
mybetween(N1,N2,X):-
    N2 - N1 > 1,
    NextN is N1 + 1,
    mybetween(NextN,N2,X).

% ex 3.22
% BROKEN as well, FIXME
:-op(1000,fx,if).
:-op(1010,xfx,:==).
:-op(1020,xfx,then).
:-op(1030,xfx,else).

