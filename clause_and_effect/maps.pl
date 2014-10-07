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

% disjoint maps
    % ie, two lists one positive, one negative from a set of numbers
% sequential
    % ie, run lenght encoding, original can be reconstructed
% scattered
    % ie, frequency distribution, original is lost

