main_even :- collect(0, 12, getEven, List), write(List).
main_sqrt :- collect(0, 12, sqrt, List), write(List).
 
getEven(N, X) :- 
    (0 =:= N mod 2) -> X = N ; X = false.

collect(From, To, Func, Xs) :-
  call(Func, From, X),
  (
    (From < To, X \= false) ->
      Next is From+1,
      Xs = [X|Rest],
      collect(Next, To, Func, Rest)
    ;
        From < To,
        Next is From+1, collect(Next, To, Func, Xs)
      ;  
        Xs = []
  ).
   
