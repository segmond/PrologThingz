% directed graph
link(a,b).
link(a,c).
link(b,d).
link(c,d).
link(c,f).
link(d,e).
link(d,f).
link(f,a).

path(N,N).
%:path(Start,End):-
%    link(Start,End).
path(Start,End):-
    link(Start,MidPoint),
    path(MidPoint,End).

ppath(N,N).
ppath(Start,End):-
    link(Start,End).
ppath(Start,End):-
    ppath(Start,End,[]).
ppath(Start,End,Acc):-
    link(Start,MidPoint),
    \+ seen_path(MidPoint, Acc),
    ppath(MidPoint,End, [MidPoint|Acc]).

seen_path(H, [H|T]).
seen_path(H, [X|T]):-
    seen_path(H,T).

path2(N,N,[N]).
path2(S,E,[S|R]):-
    link(S,NN),
    path2(NN,E,R).

/*
%find all paths from a to end with 4 possible paths
length(Path,4),path2(a,End,Path).

%find all paths
append(Path,_,_),path2(a,End,Path).
*/

% section 4.4
% solving cryptarithmetic problems
%   D O N A L D
% + G E R A L D
% = R O B E R T

%donald(ListofLetters)

/*
 * Ugly, inefficient and wrong. 
 * using digit and trying to permuate like that was wrong, i should have permuated...
?- time(donald([D,O,N,A,L,G,E,R,B,T])).
% 2,441,273,664 inferences, 241.068 CPU in 241.232 seconds (100% CPU, 10126903 Lips)
D = 6,
O = B, B = 1,
N = T, T = 2,
A = E, E = 9,
L = 7,
G = 8,
R = 5 
*/

digit(1).  digit(2).  digit(3).  digit(4).  digit(5).
digit(6).  digit(7).  digit(8).  digit(9).
donald1([D,O,N,A,L,G,E,R,B,T]):-
    digit(D), 
    digit(O), D =\= O,
    digit(N), N =\= O,
    digit(A), A =\= N,
    digit(L), L =\= A,
    digit(G), G =\= L,
    digit(E), E =\= G,
    digit(R), R =\= E,
    digit(B), B =\= R,
    digit(T), T =\= B,
    TmpD is (D + D), T is TmpD mod 10,
    TmpR is (L + L + (TmpD // 10)), R is TmpR mod 10,
    TmpE is (A + A + (TmpR // 10)), E is TmpE mod 10,
    TmpB is (R + R + (TmpE // 10)), B is TmpB mod 10,
    TmpO is (O + E + (TmpB // 10)), O is TmpO mod 10,
    TmpR is (D + G + (TmpO // 10)), R is TmpR mod 10.


%
% ?- time(donald([D,O,N,A,L,G,E,R,B,T])).
% 15,640,079 inferences, 4.028 CPU in 4.031 seconds (100% CPU, 3882959 Lips)

donald2([D,O,N,A,L,G,E,R,B,T]):-
    assign([0,1,2,3,4,5,6,7,8,9],[D,O,N,A,L,G,E,R,B,T]),
    100000*D + 10000*O + 1000*N + 100*A + 10*L + D +
    100000*G + 10000*E + 1000*R + 100*A + 10*L + D =:=
    100000*R + 10000*O + 1000*B + 100*E + 10*R + T .


del(H, [H|T], T).
del(H, [X|T], [X|R]):-
    del(H, T, R).
assign(_, []).
assign(Digs,[D|Vars]):-
    del(D, Digs, Digs1),
    assign(Digs1, Vars).

%?- time(donald3([D,O,N,A,L,G,E,R,B,T])).
% 17,929,477 inferences, 1.819 CPU in 1.821 seconds (100% CPU, 9855872 Lips)
% better, using my approach and combined with assign

donald3([D,O,N,A,L,G,E,R,B,T]):-
    assign([0,1,2,3,4,5,6,7,8,9],[D,O,N,A,L,G,E,R,B,T]),
    TmpD is (D + D),                T is TmpD mod 10,
    TmpR is (L + L + (TmpD // 10)), R is TmpR mod 10,
    TmpE is (A + A + (TmpR // 10)), E is TmpE mod 10,
    TmpB is (N + R + (TmpE // 10)), B is TmpB mod 10,
    TmpO is (O + E + (TmpB // 10)), O is TmpO mod 10,
    R is (D + G + (TmpO // 10)).

% exercise 4.4
% puzzle(Letters, List1, List2, List3)
puzzle(Letters, L1, L2, L3):-
    reverse(L1,R1), reverse(L2,R2), reverse(L3,R3),
    assign([0,1,2,3,4,5,6,7,8,9],Letters),
    puzzle_aux(R1,R2,R3,0).

puzzle_aux([E1],[E2],[E3],Carry):-
    E3 is (E1 + E2 + (Carry // 10)).
puzzle_aux([H1|TL1],[H2|TL2],[H3|TL3],Carry):-
    TmpV is (H1 + H2 + (Carry // 10)),
    H3 is TmpV mod 10,
    puzzle_aux(TL1,TL2,TL3,TmpV).


% exercise 4.6
% square is X/Y
% jump(Square1,Square2).
knightjump_aux(X/Y, X1/Y1):-
    abs(X - X1) =:= 1,
    abs(Y - Y1) =:= 2.
knightjump_aux(X/Y, X1/Y1):-
    abs(X - X1) =:= 2,
    abs(Y - Y1) =:= 1.

knightjump(X/Y, X1/Y1):-
    findall(A,between(1,8,A),XYDomain), 
    assign(XYDomain,[X1,Y1]),
    knightjump_aux(X/Y, X1/Y1).


% find path of a knight
knightpathN(0,X/Y,[X/Y]).
knightpathN(N, X/Y, [X/Y|Path]):-
    N > 0,
    knightjump(X/Y, Square),
    NewN is N-1,
    knightpathN(NewN,Square,Path).

% ie, find knight that starts at 2/1, stops at 5/4 on second move and ends on
% any 8th row in 4 moves
% Path = [2/1, _, 5/4, _, _/8], knightpathN(4,2/1/,Path).

% tour the board, a very naive implementation
knighttour(X/Y, TourPath):-
    knighttour_aux(63, X/Y, [X/Y], TourPath).

knighttour_aux(0,X/Y, Acc, Acc).
knighttour_aux(N, X/Y, Acc, Path):-
    N > 0,
    knightjump(X/Y, Square),
    \+ member(Square, Acc),
    NewN is N-1,
    knighttour_aux(NewN,Square,[Square|Acc],Path).
