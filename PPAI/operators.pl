% f = operators
% x and y represent arguments
% infix - xfx, xfy, yfx
% prefix - fx, fy
% postifx - xf, yf
% x represents arguments whose precedence must be strictly lower than the operator
% y represetns arguments whose precedence is lower or equal to the the operator

:-op(600, xfx, has).
:-op(600, xfx, supports).
:-op(700, xfy, bar).
:-op(700, yfx, foo).
:-op(800, fy, goodnot). 
:-op(800, fx, badnot).

peter has information.
floor supports table.

book bar table.
cup foo spoon.

goodnot goodnot p. % interpred as goodnot goodnot p
badnot(badnot p). % workable.
%badnot badnot p. %will fail, % interpreted as badnot <- argument to badnut p


% Morgan's equivalence theorm
% equivalence(not(and(A,B), or(not(A), not(B))).
% ~(A & B) <===> ~A v ~B

:-op(850, xfx, <===>).
:-op(750, xfy, v).
:-op(650, xfy, &).
:-op(550, fy, ~).
