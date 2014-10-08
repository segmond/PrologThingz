% full mapping
    % one to one mapping

sqlist([],[]).
sqlist([A|X],[B|Y]) :-
    B is A*A,
    sqlist(X,Y).

sqterm([],[]).
sqterm([A|X],[sqr(A,B)|Y]) :-
    B is A*A,
    sqterm(X,Y).

squint([],[]).
squint([A|X],[B|Y]) :-
    integer(A), !,
    B is A*A,
    squint(X,Y).
% must be a non integer
squint([A|X],[A|Y]) :-
    squint(X,Y).


% partial mapping
    % ie, sum of list
evens([], []).
evens([H|T], [H|R]) :-
    0 =:= H mod 2,
    evens(T, R).
% head is odd, skip it.
evens([_|T], R) :-
    evens(T,R).

prohibit(blast).
prohibit(crap).
prohibit(blah).

censor([],[]).
censor([H|T], [H|R]) :-
    \+ prohibit(H), !,
    censor(T,R).
censor([_|T], R) :-
    censor(T, R).

setify([],[]).
setify([H|T], L) :-
    member(H, T),
    !,
    setify(T,L).
setify([H|T], [H|R]) :-
    setify(T,R).

% disjoint maps
    % ie, two lists one positive, one negative from a set of numbers

% separate herd into sheeps and goats
herd([],[],[],[]).
herd([sheep|T],[sheep|S], G, O) :-
    !,
    herd(T,S,G,O).
herd([goat|T],S,[goat|G],O) :-
    !,
    herd(T,S,G,O).
herd([H|T],S,G,[H|O]) :-
    herd(T,S,G,O).


alternate(L,Even,Odd).
alternate(odd,[],[],[]).
alternate(even,[H|T],[H|E],O) :-
    alternate(odd,T,E,O).
alternate(odd,[H|T],E,[H|O]) :-
    alternate(even,T,E,O).

% firstcol(M,C), succeds for the matrix that has list C as it's first column
firstcol([[]|_],[]).
firstcol([[A|B]|M],[A|C]) :-
    firstcol([B|M],C).

% firstcol(M,C), succeds for the matrix that has list C as it's first tranposed column
first_transpose_col([],[]).
first_transpose_col([[A|B]|M],[A|C]) :-
    first_transpose_col(M,C).

next_transpose_col([],[]).
next_transpose_col([[A|B]|M],[B|C]) :-
    next_transpose_col(M,C).

slower_transpose([[]|_], []).
slower_transpose(M, [C|R]) :-
    first_transpose_col(M, C),
    next_transpose_col(M,N),
    slower_transpose(N,R).

transpose([[]|_],[]).
transpose(M, [H|Trm]) :-
    chopcol(M,H,T), 
    transpose(T,Trm).

% chop col, chops up a matrix, return the first col and the rest of the matrix
chopcol([],[],[]).
chopcol([[A|B]|M],[A|C],[B|T]):-
    chopcol(M,C,T).
    

% sequential
    % ie, run lenght encoding, original can be reconstructed
% scattered
    % ie, frequency distribution, original is lost

