% takeout an element from list
takeout(H, [H|T], T).
takeout(H, [X|T], [X|L]):-
    takeout(H,T,L).

% permutate a list
perm([X|Y],Z) :-
    perm(Y,W), 
    takeout(X, Z, W).
perm([],[]).

% eight-queens problem
% solution(Pos)
solution([]).
solution([X/Y | Others]):-
    solution(Others),
    member(Y,[1,2,3,4,5,6,7,8]),
    noattack(X/Y,Others).

noattack(_/_,[]).
noattack(X/Y,[X1/Y1 | Others]):-
    Y =\= Y1,
    Y1 - Y =\=  X1 - X,
    Y1 - Y =\=  X - X1,
    noattack(X/Y, Others).

% above solution modified to use negation as failure
solution4([]).
solution4([X/Y | Others]):-
    solution4(Others),
    member(Y,[1,2,3,4,5,6,7,8]),
    \+ attack(X/Y,Others).

attack(X/Y, Others):-
    member(X1/Y1, Others),
    (
    Y1 = Y;
    Y1 is Y + X1 - X;
    Y1 is Y - X1 + X
    ).

template([1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).

test_solution4(Sol):-
    template(Sol), solution(Sol).

% solution 2
% represent the board using only Y-coordinates
solution2(S):-
    perm([1,2,3,4,5,6,7,8],S),
    safe(S).

% Queens is a list of Y-coordinates of non attacking queens
safe([]).
safe([Queen|Others]):-
    safe(Others),
    noattack2(Queen,Others,1).

noattack2(_,[],_).
noattack2(Y,[Y1| Others],Xdistance):-
    Y1 - Y =\=  Xdistance, % not upward diagonal attack
    Y - Y1 =\=  Xdistance, % not downward diagonal attack
    NewDist is Xdistance+1,
    noattack2(Y, Others, NewDist).

% solution3(S)
solution3(Ylist):-
    solve(Ylist,
        [1,2,3,4,5,6,7,8],  % domain for X-coordinates
        [1,2,3,4,5,6,7,8],  % domain for Y-coordinates
        [-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7], % upward diag
        [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]). % downward diag

solve([],[],Dy,Du,Dv).
solve([Y|Ylist],[X|Dx1],Dy,Du,Dv):-
    takeout(Y,Dy,Dy1),  % choose a Y-coordinate
    U is X-Y,           % corresponding upward diag
    takeout(U,Du,Du1),  % remove it
    V is X + Y,         % corresponding downward diag
    takeout(V,Dv,Dv1),  % remove it
    solve(Ylist,Dx1,Dy1,Du1,Dv1).

% mechanize generation of the domains
mygen(N1,N2,List):-
   findall(X,between(N1,N2,X),XYDomain), 
   UpDiagUpper is N2-1,
   UpDiagLower is 0 - UpDiagUpper,
   findall(X,between(UpDiagLower,UpDiagUpper,X),UpDiagDomain),
   DownDiagUpper is N2+N2,
   findall(X,between(2,DownDiagUpper,X),DownDiagDomain),
   List = [XYDomain,XYDomain,UpDiagDomain,DownDiagDomain].

mynsolution(N,Res):-
    mygen(1,N,[X,Y,U,D]),
    solve(Res,X,Y,U,D).

gen(N,N,[N]).
gen(N1,N2,[N1|List]):-
    N1 < N2,
    M is N1 + 1,
    gen(M,N2,List).

nsolution(N,Res):-
    gen(1,N,Dxy),
    Nu1 is 1-N, Nu2 is N-1,
    gen(Nu1,Nu2,Du),
    Nv2 is N+N,
    gen(2,Nv2,Dv),
    solve(Res,Dxy,Dxy,Du,Dv).
