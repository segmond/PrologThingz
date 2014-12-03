%
eval(Exp, SymbolValues, Val):-
    subst_symbols(Exp, SymbolValues, Exp1),
    Val is Exp1.

%substitute(Subterm, Term, Subterm1, Term1)
%   if all occurences of Subterm in Term are substituted with Subterm1 then we get Term1

% case 1: substitute whole term
substitute(Term, Term, Term1, Term1) :- !.

% case 2: nothing to substitute if term atomic
substitute(_, Term, _, Term):-
    atomic(Term),
    !.

% case 3: do substitution on arguments
substitute(Sub, Term, Sub1, Term1):-
    Term =.. [F | Args],                    % get arguments
    substlist(Sub, Args, Sub1, Args1),      % perform substitution on tem
    Term1 =.. [F | Args1].                  % construct Term1


substlist(_, [], _, []).

substlist(Sub, [Term | Terms], Sub1, [Term1 | Terms1]):-
    substitute(Sub, Term, Sub1, Term1),
    substlist(Sub, Terms, Sub1, Terms1).


subst_symbols(Exp, [], Exp).

subst_symbols(Exp0, [Symbol = Number | SymbolValues], Exp):-
    substitute(Symbol, Exp0, Number, Exp1), % subst Symbol by Number giving Exp1
    subst_symbols(Exp1, SymbolValues, Exp). % substitute remaining symbols

test:-
    Expr = x*sin((x+y)/2), 
    Symbols = [x = 1, y = 2.14],
    eval(Expr, Symbols, Val),
    format('Expr = ~w with Symbols = ~w gives ~w~n', [Expr, Symbols, Val]).

