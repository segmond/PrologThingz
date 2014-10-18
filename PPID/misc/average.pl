average(L,R):-
    average_aux(L,0,0,R).
average_aux([],TotalCnt,Cnt,R):-
    R is TotalCnt / Cnt.
average_aux([H|T],Total,Cnt,R):-
    NewTotal is Total + H,
    Newcnt is Cnt+1,
    average_aux(T,NewTotal,Newcnt,R).


average2(L,R):-
    average_aux2(L,0,1,R).
average_aux2([],PAvg,_,PAvg).
average_aux2([H|T],PAvg,Cnt,R):-
    NewAvg is ((PAvg * (Cnt - 1)) + H) / Cnt,
    average_aux2(T,NewAvg,Cnt+1,R).
