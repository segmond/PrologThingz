%
beat(tom, jim).
beat(ann, tom).
beat(pat, jim).

% class(Player, Category)
%   winner - every player who won all his games
%   fighter - won some, lost some
%   sportsman - lost all his games

class(P, fighter):-
    beat(_, P),
    beat(P, _),
    !.

class(P, winner):-
    beat(P, _), 
    !.

class(P, sportsman):-
    \+ beat(P, _). 


%ex 5.1
p(1).
p(2):-!.
p(3).

animal(dog).
animal(cat).
snake(snake).

%Negation as failure

% mary likes all animals but snakes
% we can't backtrack this
likes(mary, X):-
    snake(X), !,  fail
    ; 
    animal(X).

different(X, Y):-
    X \= Y, !, fail
    ;
    true.

% only applies to closed world assumption
mynot(P):-
    P, !, fail
    ; 
    true.

% backtrackable
likes2(mary, X):-
    animal(X),
    mynot(snake(X)).
