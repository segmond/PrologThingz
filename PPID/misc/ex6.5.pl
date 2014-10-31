% fido is a dog
dog(fido).
cat(felix).

% dogs are animals
animal(X) :-
    dog(X).

% Are dogs animals?

% INTENSIONAL
%1 - Is there a rule/rules by which all dogs can be proven to be animals?

% EXTENSIONAL
%2 - Regardless of the rules, Is it the case that all dogs actually listed 
%        in the KB are in fact animals?

for_all(GoalA, GoalB):-
    \+ (call(GoalA), \+ call(GoalB)),
    call(GoalA),
    !.
