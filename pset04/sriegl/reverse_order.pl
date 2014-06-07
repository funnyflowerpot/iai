/*
Define a predicate:

 reverse_order(L1,L2)

such that L2 contains all elements of L1 in reverse order.
sublists should not be changed!

Examples:

 reverse_order([a,b,c,d],L).
   L=[d,c,b,a]

 reverse_order([a,[b,c,d],e],L).
   L=[e,[b,c,d],a]

start with an empty list

using normal recursion to reverse the
rest list leads to the problem to add
the first element to the end of the reversed rest

a simple way to add an element at the end of a
list is to append an one element list using a suitable
predicate (have look at the manual)
*/


% reverse_order(?L1, ?L2)
% True, if L2 contains all and only elements of L1 in reversed order.

% reverse_order/2 for empty lists is true by definition.
reverse_order([], []).

% reverse_order/2 is true, if the first element E of L1 is the last element
% of L2 (via append/3) and the rest of L2 is the reversed rest of L1. Mind
% the order of the predicates, otherwise a infinite loop would occur because
% of two uninstantiated variables for append/3.
reverse_order([E|R1], L2) :-
	reverse_order(R1, R2),
	append(R2, [E], L2).
	