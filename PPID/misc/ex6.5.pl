% fido is a dog
dog(fido).
dog(rover).
dog(X):-
    bulldog(X).

bulldog(bucephalus).


% dogs are animals
animal(X) :-
    dog(X).
animal(felix).

cat(felix).


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

/*
Are all dogs animals?
?- for_all(dog(X), animal(X)).
X = fido.

Are all bulldogs animals?
?- for_all(bulldog(X), animal(X)).
X = bucephalus.

are all dog bulldogs?
?- for_all(dog(X), bulldog(X)).
false.
*/
