/*
Define operators and the predicate # and ?? such that
- the following input can be read by prolog without an error message:
-- # marc traveled from frankfurt to berlin where he visited his mother.
- at the prolog command line prolog will perform the following action:
-- print the terms (one per line):
      traveled(marc, to(from(frankfurt), berlin))
      visited(he, his(mother))
-- add the above two term as argument of the predicate facts:
      facts(traveled(marc, to(from(frankfurt), berlin)))
      facts(visited(he, his(mother)))
   into the prolog knowledge base as clauses for a predicate 'facts'

?- # marc traveled from frankfurt to berlin where he visited his mother.

define an operator ?? such that 

?- Who traveled from Pos1 to Pos2 ?? .
gives the answer:
Who = marc
Pos1 = frankfurt
Pos2 = berlin

and
?- Who visited his mother ?? .
gives the answer:
Who = he
*/

% you code goes here:


% operator precedence (remaining words must be operators):
%
% # ((marc traveled ((from frankfurt) to berlin) where (he visited (his mother))))
% # ((_ traveled ((from _) to _) where (_ visited (his _))))
%
% Inner-most operators (like "from") must have a "lower" (Prolog-lingua) 
% priority than outer operators (like "#" or "where"), so the inner ops get
% processes first.

% arguments for #(where/2) may look like this following lines should be added
% to the knowledge base and printed.
% - traveled(marc, to(from(frankfurt), berlin))
% - visited(he, his(mother))
#(where(A, B)) :-
  assert(facts(A)),
  assert(facts(B)),
  writeln(A),
  writeln(B).

% Declare operators. Only for the first we need a predicate, since all
% other will be considered as part of a data structure, rather than a
% seperate predicate. The first and second argument for op/3 follows from
% the bracketing done above.
:- op(805,  fx, #).
:- op(803, xfx, traveled).
:- op(801,  fx, from).
:- op(802, xfx, to).
:- op(804, xfx, where).
:- op(803, xfx, visited).
:- op(802,  fx, his).


% "this line will be processes as if it were entered as aquery:"
% This line will extend the knowledge base (via assert/1 in #/1).
:- # marc traveled from frankfurt to berlin where he visited his mother.



% operator precedence
% Who traveled from Pos1 to Pos2 ?? .
% (_ traveled ((from _) to _)) ?? .

% A query with ??/1 will only be true, if the preceding predicate is
% listed as a fact. 
??(X) :- facts(X).
:- op(805, xf , ??).

% It follows, that the only
% distinguishable results for the respective queries will be:
% ?- X ?? , X = traveled(_,_).
% X = (marc traveled from frankfurt to berlin).
% ?- X ?? , X = visited(_,_).
% X = (he visited his mother).

