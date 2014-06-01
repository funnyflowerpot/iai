/**
* Concatination List
* 
* a) Define a predicate:
*
* concat_list(L1,L2,L3)
* which is true if and only if
* L3 = L1 + L2
* (+ means concatenation here)
* 
* author: pwicke
* group: pwicke, sriegl, ktrebing, tgrenzdoerff
* date: 20.05.2014
**/

% concat_list(?L1,?L2,?L3)
% Whereas at only ONE parameter can be unbound

% true: as empty list concat to one emoty list
concat_list([],[],[]).

% true: if first list is empty
% if the first list is empty, chop of the head of L2 and put it in again,
% until you reach the first clause. Then T3 will be put together by recursion.
% such that T1=[], T2=T3
concat_list([],[H2|T2],[H2|T3]) :- concat_list([],T2,T3).

% Right side is true iff T1 and L2 form one of the cases above, as T1 and L2 are lists 
% there will be a recusion with T1 being the NEXT Tail of L1 and L2 as L2 and T3 as 
% the first argument of L1. This recursion loops and keeps NEXT'ing L1 until T1 is empty.
% At this point the second clause is true and starts concatinating T3.
concat_list([H1|T1],L2,[H1|T3]) :- concat_list(T1,L2,T3).


/* b) Try:
		concat_list(L1,L2,[1,2,3,4]).
	Explain the result!

Result:
L1 = [],				L1 = [1],				L1 = [1, 2],			L1 = [1, 2, 3],
L2 = [1, 2, 3, 4] ;		L2 = [2, 3, 4] ;		L2 = [3, 4] ;			L2 = [4] ;

L1 = [1, 2, 3, 4],
L2 = [].			
 
This query asks Prolog if there are two lists which can be concatinated to form a list 
containing [1, 2, 3, 4]. These are obviously the empty sets plus the demanded list in both 
combinations. As well as all combinations between the length of the lists, so the first list
with one element of the demanded list an the rest in the second list, the first list with two
elements, three and four. This results in 5 different combinations.

(c)
Try:

   concat_list(L1,[a,b],L2).

Explain the result!

Result:
L1 = [],			L1 = [_G8606],				L1 = [_G8606, _G8612],
L2 = [a, b] ;		L2 = [_G8606, a, b] ;		L2 = [_G8606, _G8612, a, b] ;

L1 = [_G8606, _G8612, _G8618],
L2 = [_G8606, _G8612, _G8618, a, b] ;

The query asks Prolog if a list can be built that contains at least the list [a,b] and
any other list or empty list. 
Prolog starts with the second clause, that is an empty first list. And this clause
puts the second list as the concatinated list.
Then Prolog proceeds with ANY value represented by _G8606 (IN THIS CASE!!!) and concatinates
this random value with a,b, which will be put at the end of the list - as specified by the clause.
Then Prolog will go on to fill the list with random values until you stop asking for more lists.
*/
