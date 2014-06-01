/*
Define a predicate:

   zip_list(L,L1,L2)

L is a list containing all elements from L1 and L2.
The first element of L should be the first of L1 ,
the second of L should be the first of L2,
the third of L should be the second of L1,
etc.
Example:
   zip_list(L,[1,2,3],[a,b,c]).
       L=[1, a, 2, b, 3, c]

L1 and L2 need not to be of equal length.
If 'zip_list' is called with uninstantiated L,
the elements of the longer list of L1 and L2 should be
all present in L.
This has effects to calls with L instantiated.
Which?

Examples:
   zip_list(L,[1,2,3],[a,b,c,d]).
       L=[1, a, 2, b, 3, c, d]
   zip_list(L,[1,2,3,4,5],[a,b,c]).
       L=[1, a, 2, b, 3, c, 4, 5]
   zip_list([1,2,1,2,1,2],[1,1,1],L).
       L=[2, 2, 2]


Hints:
Use two predicates which call each other alternately
if one of L1 or L2 is empty return the other
else add the element to L and call the other predicate

to see the problems with instantiated first argument try 

      zip_list([1,2,3,4,5],X,Y)

and discuss the result
*/
% ANCHOR
zip_list([], [], []).

% When only L1 still has Elements
zip_list( [L1_Head | Rest_Final], [L1_Head|L1_Tail], []) :- zip_list(Rest_Final, L1_Tail, []).
%                  ?-  zip_list(X,[1,2,3,4,5],[]).

% When only L2 still has Elements
zip_list( [L2_Head | Rest_Final], [], [L2_Head | L2_Tail]) :- zip_list(Rest_Final, [], L2_Tail).

% When in both Lists are at least 1 Element
zip_list([L1_Head, L2_Head | Rest_Final], [L1_Head | L1_Tail], [L2_Head | L2_Tail]) :- zip_list(Rest_Final, L1_Tail, L2_Tail).
%											^^^^^^^^^^^^	

% zip_list(_LFinal, [], []).

/*
L3[___________]			clause1:[Head_L1, Head_L2 | Rest]
L1[XXXXX]      5x  				nehme ein X und ein Y, mache es zu [XY|Rest]
L2[YYYYYYY]	   7x				rekursiv:
								L3[XY XY XY XY XY|Rest]
huch, L1 ist leer <-------------L1[_____]					ODER
also wird ein neuer clause  	L2[YYY____]					huch, L2 ist leer
aufgerufen:												
clause2: F�LLE L2 an das Ende  L3[XY XY XY XY XY YY Y]		clause2b: F�LLE L1 ans Ende
							   L1[_____]
							   L2[_______]	
huch, L1 & L2 sind leer <------------------
clause3: [L3][][]
Recursion, bef�llt L3 [XY XY XY XY XY YY Y]
*/
