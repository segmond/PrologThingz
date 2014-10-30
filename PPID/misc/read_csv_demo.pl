% csv reading demo
% http://www.swi-prolog.org/pldoc/man?section=csv
:- use_module(library(csv)).


demo:-
    atom_codes(':',[Sep]),
    csv_read_file('/etc/passwd', Rows, [functor(userinfo), separator(Sep)]), 
    maplist(assert,Rows),
    dump_csv_lines(Rows).


dump_csv_lines([]).

dump_csv_lines([H|T]):-
    writeln(H),
    dump_csv_lines(T).


demo_write:-
    Data = [line(a,b,c), line(d,e,f), line(1,2,3,4)],
    csv_write_file('csv_test.csv', Data, [functor(line)]).
