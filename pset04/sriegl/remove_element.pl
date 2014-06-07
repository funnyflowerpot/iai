/*
define a predicate:

    remove_element(?E,+L1,?L2)

which is true if E occurs in L1 and L2 is derived from
L1 by removing ONE occurence of E.

Example:

  remove_element(c,[a,c,b,c,d],L2)
  L2=[a,b,c,d];
  L2=[a,c,b,d]



Example query: remove_element(c,[a,c,b,c,d],L2)
*/

% remove_element(?E,+L1,?L2)

% If E is equal to the first element of L1, then remove_element/3 is true and
% the tail of L1 (without first element) is equal to L2.
remove_element(Element, [Element|R], R).

% If E is not equal to first element of L1, then assume E to be first element 
% of L2 as well and try to prove remove_element/3 for respective tails of L1
% and L2.
remove_element(Element, [First|R1], [First|R2]) :-
	remove_element(Element, R1, R2).
	