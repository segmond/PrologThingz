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

ex(a, /* rotation by theta about the Y axis */
    [[ cos(theta),  0,  -sin(theta),    0],
     [ 0,           1,  0,              0],
     [ sin(theta),  0,  cos(theta),     0],
     [ 0,           0,  0,              1]]).
     
ex(b, /* rotation by phi about the X axis */
    [[ 1,   0,          0,          0],
     [ 0,   cos(phi),   sin(phi),   0],
     [ 0,   -sin(phi),  cos(phi),   0],
     [ 0,   0,          0,          1]]).

ex(c, /* rotation by psi about the Z axis */
    [[ cos(psi),   sin(psi),   0,   0],
     [ -sin(psi),  cos(psi),   0,   0],
     [ 0,   0,          1,          0],
     [ 0,   0,          0,          1]]).


/* simplify each element of a matrix */
simplist([],[]).
simplist([[H|T]|Z], [R|S]):- !, simplist([H|T],R), simplist(Z,S).
simplist([H|T], [R|S]):- !, simp(H,R), simplist(T,S).

