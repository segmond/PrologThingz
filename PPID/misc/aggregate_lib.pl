:-use_module(library(aggregate)).

father(john, mike).
father(john, jane).
father(ken, john).
father(david, brad).



start:-
    forall(member(Result = Formula, [2 = 1 + 1, 4 = 2 * 2]), 
        Result =:= Formula),
    forall(member(Father-Child, [john-mike, john-jane, david-brad]), 
        father(Father, Child)).
