% matrix products by symbolic algebra

% product of two matrices
mm(A,B,C):-
    mytranspose(B,BT),
    mmt(A,BT,C).

% transpose a matrix
mytranspose([[]|_],[]).
mytranspose(M, [Ci|Cn]):-
    columns(M,Ci,R),
    mytranspose(R,Cn).

columns([], [], []).
columns([[Cii|Cin]|C], [Cii|X],[Cin|Y]):-
    columns(C,X,Y).

% product of all rows of A with entire B
mmt([],_,[]).
mmt([Ai|An],B,[Ci|Cn]):-
    mmc(Ai,B,Ci),
    mmt(An,B,Cn).

% product of all columns of B with row A
mmc(_,[],[]).
mmc(A,[Bi|Bn],[Ci|Cn]):-
    ip(A,Bi,Ci),
    mmc(A,Bn,Cn).

% inner product of two vectors
ip([],[],0).
ip([Ai|An],[Bi|Bn],(X+Ai*Bi)):-
    ip(An,Bn,X).
