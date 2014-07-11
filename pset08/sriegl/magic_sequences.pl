%-------------------------------------------------
% Define a predicate
%      magic_sequence(+N,-Sequence)
% which constructs a magic sequence of length N
%
% a magic sequence is a sequence of integers
%    S = [x0, x1, ..., xn-1]
% such that xi = |{j : xj = i}|
% (the value at position i is the number of occurrences
%  of i in the whole sequence)
%
% The following sequence is magic:
%    [2,1,2,0,0]
% since we have 
%     2 times a 0
%     1 time  a 1
%     2 times a 2
%     0 times a 3
%     0 times a 4 
%
% compute all magic sequences of length N
%
% Hints:
% - implement a generate and test approach
% - try to optimize it by using properties of
%   magic sequences as additional constraints
%   e.g. xi =< N-i (there much stronger constraints)
% - you can use length(-S,+N) to construct
%   a list of length N with N free variables
%   as elements
%-------------------------------------------------

doit :-
  between(0,8,N),
  magic_sequence(N,S),
  writeln(N:S),
  fail.

doit.


%
% A usual test run:
%
/*
?- time(doit).
0:[]
4:[1,2,1,0]
4:[2,0,2,0]
5:[2,1,2,0,0]
7:[3,2,1,1,0,0,0]
8:[4,2,1,0,1,0,0,0]
% 204,982 inferences, 0,048 CPU in 0,048 seconds (100% CPU, 4237052 Lips)
true.
*/


% magic_sequence(+N,-Sequence)
% Instantiates a magic sequence for a given length N. The strategy is
% generate and test.
magic_sequence(Length, Sequence) :-
  % set length for sequence to be returned
  length(Sequence, Length),
  % generate some sequence
  fill_ints(Sequence, Length),
  % test sequence on magic-ness
  check_items(Sequence, Sequence, 0, Length).


% fill_ints(?Sequence, +Amount)
% Distribute summands of a total Amount to elements of a Sequence. The length
% of Sequence should be bound, for receiving more than one instantion of
% Sequence.
%
% The predicate works as follows: Subtract a number from amount and
% instantiate the head of the sequence with that number. Use this predicate
% recursively with the tail of the sequence and the remaining amount. Allow
% successful prove of predicate only if the predicate gets called with an
% empty sequence and no amount (i.e. Amount=0) left to distribute.
%
% An example output for "?- length(X, 3), fill_ints(X,4)." would be:
%   X = [4, 0, 0] ; X = [3, 1, 0] ; X = [2, 2, 0] ; X = [1, 3, 0] ; 
%   X = [0, 4, 0] ; X = [3, 0, 1] ; X = [2, 1, 1] ; X = [1, 2, 1] ; 
%   X = [0, 3, 1] ; X = [2, 0, 2] ; X = [1, 1, 2] ; X = [0, 2, 2] ; 
%   X = [1, 0, 3] ; X = [0, 1, 3] ; X = [0, 0, 4] ; false.
%
% (If the length of the Sequence is bound, the "next best" length of 1 will
% be assumed. So "?- fill_ints(X, 3)." would yield "X = [3]".) 

% only allow successful prove if no items in sequence left _and_ nothing left
% to distribute
fill_ints([], 0).
fill_ints([SequenceHead|SequenceTail], AmountLeft) :-
  % _generate_ the new, diminished amount
  between(0, AmountLeft, SequenceHead),
  % head of sequence equals difference of former amount and new amount 
  NewAmountLeft is AmountLeft - SequenceHead,
  % continue for other sequence items and remaining amount
  fill_ints(SequenceTail, NewAmountLeft).


% select_n(+Elem, +List1, -List2, ?N)
% Like the built-in predicate select/3, but allow for N selections instead of
% only one. See the documentation of select/3 for details. B-) :D
%
% Cuts were used to optimize inference time.
%
% (There are built-in predicates, that might do similar things, but this
% implementation turned out to be more efficient than tested ones.)

% True, since nothing to do.
select_n(_, [], [], 0).
% If the Elem in interest is the head of List1, skip it (i.e. Elem is the
% head of argument "[Elem|List1Rest]", but not of argument "List2") and 
% continue with the other elements. Increment counter N of skipped elements.
select_n(Elem, [Elem|List1Rest], List2, NPlusOne) :-
  !, select_n(Elem, List1Rest, List2, N),
  NPlusOne is N + 1.
% If the Elem in interest is not the head of List1, let the head of List1
% also appear as the head of List2 and continue.
% Since the former definition of select_n/4 handles equality of Elem with
% head of List1 and cuts are used, we do not have to check on inequality of
% Elem and OtherElem.
select_n(Elem, [OtherElem|List1Rest], [OtherElem|List2Rest], N) :-
  !, select_n(Elem, List1Rest, List2Rest, N).
 
 
% check_items(+Sequence, +ItemsToCheck, +Index, +Length)
% True, if Sequence is a magic sequence. ItemsToCheck should be initialized
% with the same Variable as Sequence. Index should be initialized with 0 and
% Length with the length of Sequence. An interface predicate was not intro-
% duced, since check_items/4 is an internal helper predicate for doit/0 and
% more predicates means mores inferences, which we want to minimize. ;-)
%
% A Sequence is magical, if it holds that for all indexes of elements in the
% sequence, an index appears exactly n times, where n is the value in the 
% sequence, denoted by the index. Indices start with 0. This property gets
% checked for the whole sequence, starting with sequence head and proceeding
% by recursion.
%
% If one index fulfills the magic property, all values denoted by the index
% get removed from a "WorkSequence", that must be empty in the same predicate
% when the running Index got incremented to reach Length.

% Sequence is magical iff no items are left to check and we have checked all
% available indexes (i.e. the running Index was increased until it is equal
% to Length).
check_items(_, [], Length, Length).
% Check if the head of sequence fulfills the "magic property", as stated
% above. Index always determines the index of the current SequenceHead.
check_items([SequenceHead|SequenceTail], ItemsToCheck, Index, Length) :-
  % RemainingItemsToCheck is the result, when all elements that unify with
  % Index get removed from ItemsToCheck and the number of removed elements
  % is SequenceHead
  % e.g.: if "?- select_n(2, [2,1,2,0,0], RemainingItemsToCheck, 2)." would
  % yield "RemainingItemsToCheck = [1,0,0]".
  % admittedly, the variable naming here is ugly, but so is the definition of
  % magic sequences too
  select_n(Index, ItemsToCheck, RemainingItemsToCheck, SequenceHead),
  IndexPlusOne is Index + 1,
  !, check_items(SequenceTail, RemainingItemsToCheck, IndexPlusOne, Length).
