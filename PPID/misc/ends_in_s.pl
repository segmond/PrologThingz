%ends_in_s(String|List)
%   Succeeds if the string ends in s or 115
%   Otherwise, it fails
ends_in_s([H|T]):-
    ends_in_s(T).
    
ends_in_s([115]).
ends_in_s([]):- fail.
