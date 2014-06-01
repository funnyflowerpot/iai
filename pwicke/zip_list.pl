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
*/

% L3 [H3|T3]	L3 = [H1,H2,T1,T2]
% L1 [H1|T1]	L1 = [1a,1b,1c,...]
% L2 [H2|T2]	L2 = [2a,2b,2c,...]

% This clause will stop recursion: if all lists are empty -> true
zip_list([],[],[]).

% This clause will respond to larger L2 lists. It will cut down L2 and feed it
% to the end of L3
zip_list([H2|L3],[],[H2|T2]) :- zip_list(L3,[],T2).

% This clause will respond to larger L1 lists. It will cut down L1 and feed it
% to the end of L3
zip_list([H1|L3],[H1|T1],[]) :- zip_list(L3,T1,[]).

% This is the main clause. It will cut down both lists and feed them to the end
% of list L3 by putting one argument of L1 followed by one argument of L2.
zip_list([H1,H2|T3],[H1|T1],[H2|T2]) :- zip_list(T3,T1,T2).

/*
This has effects to calls with L instantiated.
Which?

 The effects, that all possible combinations of uninstantiated variables
 will get listed. Notable in this case is the fact, that it is ambiguous
 which element of L is belonging to L1 rather than L2 and vice versa.
 Result of query: ?- zip_list([1,A,2,B,3,C],X,Y).
 X = [],					X = [1, A, 2, B, 3, C],		X = [1],
 Y = [1, A, 2, B, 3, C] ;	Y = [] ;					Y = [A, 2, B, 3, C] ;
 
 X = [1, 2, B, 3, C],		X = [1, 2],					X = [1, 2, 3, C],
 Y = [A] ;					Y = [A, B, 3, C] ;			Y = [A, B] ;		AND SO ON

 To bypass this behavoir of Prolog and to get more precise results, the 
 length of L1 or L2 can be specified like this:
 ?-zip_list([1,A,2,B,3,C],X,[_,_,_]).
 For this query will then be only one result: X = [1, 2, 3].
 */