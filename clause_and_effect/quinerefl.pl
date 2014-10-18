% Language: Prolog
% Author: Markus Triska (triska@gmx.at)
% Notes: Prolog is fully reflexive, allowing for a concise quine.
% Tested with SWI Prolog 5.6.20

quine :-
	clause(quine, A),
	portray_clause((quine:-A)).
