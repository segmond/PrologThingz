solve_max(A,B) :- maximum(A,B,C),thread_exit(C).

maximum(X,Y,Y) :- X =< Y,!.
maximum(X,_,X).

start :- thread_create(solve_max(5,6),Id1,[]),
         thread_create(solve_max(8,7),Id2,[]),
         thread_create(solve_max(9,9),Id3,[]),

         thread_join(Id1,exited(X)),
         thread_join(Id2,exited(Y)),
         thread_join(Id3,exited(Z)),

         max_member(M, [X,Y,Z]),
         writeln(M).
