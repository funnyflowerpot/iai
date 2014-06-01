/*
 * listfour
 * @author: pwicke
 * @group: sriegl, pwicke, tgrenzdoerff, ktrebing
 * @date: 21.05.2014
  
 Define a predicate:

   four(L)

which ist true, if and only if
L is a list with exactly four (arbitrary) elements
*/

% four([+A,+B,+C,+D]).

four([_,_,_,_]).


/*
Try:
   four(L).
and explain the result!
 
 Result:
 L = [_G332, _G335, _G338, _G341].
 
 One asks Prolog for ANY list that contains exactly four elements.
 Therefore if you do only provide a variable, which Prolog will under-
 stand as a list, it will fill the 4 available spaces with random values.
 In this case [_G332, _G335, _G338, _G341]
 */
 

