/*
Define a predicate:

   four(L)

which ist true, if and only if
L is a list with exactly four (arbitrary) elements

Examples:
   four([1,2,3,4]).
      yes
   four([a,b,c,d]).
      yes
   four([a,b,c,d,e]).
      no
   four([1,2,3]).
      no
*/

four([_,_,_,_]).

/*
Try:
   four(L).
and explain the result!
*/

% To satisfy the predicate four/1, Prolog must find a list with four elements.
% In the definition of four/1, the elements are specified to be not 
% instantiated variables. Therefore, Prolog will assume four arbitrary
% variables as elements for a result for the query in question. These four
% variables are allowed to have different values, but need not to.
