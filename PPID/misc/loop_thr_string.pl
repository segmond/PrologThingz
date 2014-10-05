% this fails in SWI-prolog since strings are first class citizens
% will work under yap tho
% exercise 3.12.1
write_str([H|T],K,C):-
    C == K -> write(' '), put(H), write_str(T,0,1); 
    (
        C1 is C+1,
        put(H), write_str(T,K,C1)
    ).
write_str([],_,_):-
    nl.

print_splits(S):-
    print_splits(S,S,-1).

print_splits([H|T],S,K):-
    K1 is K+1,
    write_str(S,K1,0),print_splits(T,S,K1).
    
print_splits([], S, _):-
    write_str(S,0,1).
