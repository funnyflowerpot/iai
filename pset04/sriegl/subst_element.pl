/*
define a predicate:

    subst_element(?E1,?E2,+L1,?L2)

which is true if E1 occurs in L1 and L2 is derived from
L1 by substituting ONE occurence of E1 by E2.


Example:

  ?- subst_element(c,1,[a,c,b,c,d],L2).
  L2=[a,1,b,c,d];
  L2=[a,c,b,1,d]
 
Example query: subst_element(c,1,[a,c,b,c,d],L2)
*/


% subst_element(?E1,?E2,+L1,?L2)
% This predicate works mostly analogous to the predicate remove_element/3.

% If E1 is equal to the first element of L1, then subst_element/4 is true and
% the tail of L1 is equal to the tail L2, with E2 as head of L2.
subst_element(Element, Replacement, [Element|R], [Replacement|R]).

% If E1 is not equal to first element of L1, then assume E1 to be first 
% element of L2 as well and try to prove subst_element/4 for respective tails 
% of L1 and L2. Pass E2 on without further touching.
subst_element(Element, Replacement, [First|R1], [First|R2]) :-
	subst_element(Element, Replacement, R1, R2).
	