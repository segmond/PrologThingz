% rotate a list
rotall([],_,[]).
rotall([H|T],A,[L|Z]):-
    append([H|T],A,L),
    append(A,[H],A1),
    rotall(T,A1,Z).

% linearising
app(L1-L2,L3-L4,X-Y):-
    X = L1,
    L2 = L3,
    Y = L4.

testapp:-
    app([a,b,c|Z1]-Z1,[d,e|Z2]-Z2,X-Y).


% very fast, compared to regular, for 10000 items, 30k inferences instead of 50million
reverse_diff(L,R):-
    reverse_diff(L,R,[]).
reverse_diff([E], [E|End], End).
reverse_diff([H|T], X,Y):-
    X = Res,
    REnd = [H|HEnd],
    Y = HEnd,
    reverse_diff(T,Res,REnd).

% meh, just a bit better
flatten_diff(L,R):-
    flatten_diff_aux(L,R-[]).
flatten_diff_aux([],End-End).
flatten_diff_aux([H|T],Res-ResEnd):-
    flatten_diff_aux(H,FL-Flend),
    flatten_diff_aux(T,TL-Tlend),
    app(FL-Flend,TL-Tlend, Res-ResEnd).
flatten_diff_aux(E,[E|End]-End).
