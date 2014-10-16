%
first_two_same([F,F|R]).
swap_first_two([F,S|R], [S,F|R]). 

xmember(E, [E|T]).
xmember(E, [H|T]):-
    xmember(E,T).
    

last_element([E], E).
last_element([H|T], X):-
    last_element(T,X).

xappend([],X,X).
xappend([H|T],L2,[H|R]):-
    xappend(T,L2,R).
