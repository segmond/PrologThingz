% Figure 15.7  A forward chaining rule interpreter.
% Code from third edition of Bratko "Prolog Programming
% for Artificial Intelligence" Addison-Wesley, 2001.

% To use with iProlog under Unix, 
% save this code in the current working directory
% as "forward.pl", then do the following:

%   % prolog forward.pl
%   : forward?

% support code

:-dynamic(fact/1).
:-op(800, fx, if).                     % iProlog has "if" predefined
:-op(700, xfx, then).
:-op(300, xfy, or).
:-op(200, xfy, and).

% Simple forward chaining in Prolog

forward  :-
   new_derived_fact( P),             % A new fact   
   !,
   write( 'Derived: '), write( P), nl,
   assert( fact( P)),
   forward                           % Continue   
   ;
   write( 'No more facts').          % All facts derived

new_derived_fact( Concl)  :-
   if Cond then Concl,               % A rule   
   not( fact( Concl)),               % Rule's conclusion not yet a fact
   composed_fact( Cond).             % Condition true? 

composed_fact( Cond)  :-
   fact( Cond).                      % Simple fact 

composed_fact( Cond1 and Cond2)  :-
   composed_fact( Cond1),
   composed_fact( Cond2).            % Both conjuncts true 

composed_fact( Cond1 or Cond2)  :-
   composed_fact( Cond1)
   ;
   composed_fact( Cond2).

% rules

if
  hall_wet and kitchen_dry
then
  leak_in_bathroom.

if
  hall_wet and bathroom_dry
then
  problem_in_kitchen.

if
  window_closed or no_rain
then
  no_water_from_outside.

if
  problem_in_kitchen and no_water_from_outside
then
  leak_in_kitchen.

%facts

fact(hall_wet).
fact(bathroom_dry).
fact(window_closed).
