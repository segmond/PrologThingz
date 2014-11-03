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
