% rotate a list
rotall([],_,[]).
rotall([H|T],A,[L|Z]):-
    append([H|T],A,L),
    append(A,[H],A1),
    rotall(T,A1,Z).

% linearising
app(L1-L2,L3-L4,X-Y):-
    X = L1,
    L2 = L3,
    Y = L4.

testapp:-
    app([a,b,c|Z1]-Z1,[d,e|Z2]-Z2,X-Y).


% very fast, compared to regular, for 10000 items, 30k inferences instead of 50million
reverse_diff(L,R):-
    reverse_diff(L,R,[]).
reverse_diff([E], [E|End], End).
reverse_diff([H|T], X,Y):-
    X = Res,
    REnd = [H|HEnd],
    Y = HEnd,
    reverse_diff(T,Res,REnd).

% meh, just a bit better
flatten_diff(L,R):-
    flatten_diff_aux(L,R-[]).
flatten_diff_aux([],End-End).
flatten_diff_aux([H|T],Res-ResEnd):-
    flatten_diff_aux(H,FL-Flend),
    flatten_diff_aux(T,TL-Tlend),
    app(FL-Flend,TL-Tlend, Res-ResEnd).
flatten_diff_aux(E,[E|End]-End).

% the right way, join them without append
flatten_diff2(L,R):-
    flatten_diff2_aux(L,R-[]).
flatten_diff2_aux([],End-End).
flatten_diff2_aux([H|T],FL-Tlend):-
    flatten_diff2_aux(H,FL-Flend),
    flatten_diff2_aux(T,Flend-Tlend).
flatten_diff2_aux(E,[E|End]-End).

% only way is to recurse
list2dlist(L, AL-ZL) :- append(L, ZL, AL).

%linearising trees or any case where you find yourself getting result from two places append and returning
% bad
lintree(n(A,B),L) :- 
    lintree(A,LA),
    lintree(B,LB),
    append(LA,LB,L).
lintree(X,[X]):-
    integer(X).
lintree(X,[]).

%good
lintree2(X,Y) :-
    lindifftree(X,Y-[]).
lindifftree(n(A,B),L1-L3) :- 
    lindifftree(A,L1-L2),
    lindifftree(B,L2-L3).
lindifftree(X,[X|L]-L):-
    integer(X).
lindifftree(X,L-L).
% replace the result of the appends with two difference list, L1-L2, and L2-L3
% drop the append, then return L1-L3 as the result
% turn all [] into L-L, and [E] as [E|L]-L

% pick fruits from a list
picktree([], []-[],[]-[]).
picktree([H|T],A-AE,P-PE):-
    H = apple,
    A = [apple|A1],
    picktree(T,A1-AE,P-PE).
picktree([H|T],A-AE,P-PE):-
    H = pear,
    P = [pear|P1],
    picktree(T,A-AE,P1-PE).

picktree_test:-
    picktree([apple,pear,pear,pear,pear,pear,apple], S, R).


%difference structures
%normalize sum expressions, (a+b)+(b+c) or (a+(b+(c+d))) into a+b+c+d
flatsum(A+B,R1-R3):-
    flatsum(A,R1-R2),
    flatsum(B,R2-R3).
flatsum(A,[A|C]-C).


build([X],T,T+X):-!.
build([H|L],T,Z):-
    build(L,T+H,Z).

normalize1(A,C):-
    flatsum(A,B-[]),
    B = [T|L],
    build(L,T,C).

%normalized by both flattening and building in one pass
normalize2(X,Y):-
    norm(X,[],Y).
norm(A+B,R1,R3):-
    !,
    norm(A,R1,R2),
    norm(B,R2,R3).
norm(X,[],X):- !.
norm(X,A,A+X).
