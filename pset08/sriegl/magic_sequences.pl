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

%-------------------------------------------------
% magic sequence of length N
% magic_sequence(+N,-Sequence)



magic_sequence(Length, Sequence) :-
  length(Sequence, Length),
  contains_ints(Sequence, Length, Length),
%  sum_list(Sequence, Length),
%  check_items(Sequence, Sequence, 0).
  check_items4(Sequence, Sequence, 0, Length).


bam :-
  between(0,8,N),
  length(Sequence, N),
  contains_ints(Sequence, N, N).
  
  
contains_ints([], _, 0).
contains_ints(Sequence, Length, AmountLeft) :-
  append(FirstElements, [LastElement], Sequence), !,
  between(0, AmountLeft, LastElement),
  NewAmountLeft is AmountLeft - LastElement,
  contains_ints(FirstElements, Length, NewAmountLeft).


contains_ints2([], _, 0).
contains_ints2([SequenceHead|SequenceTail], Length, AmountLeft) :-
  between(0, AmountLeft, SequenceHead),
  NewAmountLeft is AmountLeft - SequenceHead,
  contains_ints(SequenceTail, Length, NewAmountLeft).


%contains_ints3(Sequence, Length) :-
  

% Index: What to be counted.
% CurrentAmount: Amount of what to be counted.
check_items([], _, _).
check_items([CurrentAmount|ItemsLeft], Sequence, Index) :-
  count(Index, Sequence, CurrentAmount),
%  writef('%w, %w, %w\n', [[CurrentAmount|ItemsLeft], Sequence, Index]),
  OtherIndex is Index + 1,
  !, check_items(ItemsLeft, Sequence, OtherIndex).


check_items1(_, [], _).
check_items1(Sequence, WorkingList, Index) :-
  nth0(Index, Sequence, Element),
  delete(WorkingList, Element, NewWorkingList),
  NewIndex is Index + 1, !,
  check_items(Sequence, NewWorkingList, NewIndex).


delete_n_times(List, _, 0, List).
delete_n_times(List, Elem, N, ResultList) :-  
  NMinusOne is N - 1,
  select(Elem, List, ReducedList), !,
  delete_n_times(ReducedList, Elem, NMinusOne, ResultList).


%select_n(+Elem, +List1, -List2, ?N)
select_n(_, [], [], 0).
select_n(Elem, [Elem|List1Rest], List2, NPlusOne) :-
  !, select_n(Elem, List1Rest, List2, N),
  NPlusOne is N + 1.
select_n(Elem, [OtherElem|List1Rest], [OtherElem|List2Rest], N) :-
  OtherElem \= Elem,
  !, select_n(Elem, List1Rest, List2Rest, N).
 
 
check_items2(_, [], Length, Length).
check_items2([SequenceHead|SequenceTail], WorkingList, Index, Length) :-
  delete_n_times(WorkingList, Index, SequenceHead, ModifiedWorkingList),
  IndexPlusOne is Index + 1, !,
  check_items2(SequenceTail, ModifiedWorkingList, IndexPlusOne, Length).

check_items3(_, [], Length, Length).
check_items3([SequenceHead|SequenceTail], ItemsToCheck, Index, Length) :-
  delete_all(ItemsToCheck, Index, RemainingItemsToCheck, SequenceHead),
  IndexPlusOne is Index + 1,
  !, check_items3(SequenceTail, RemainingItemsToCheck, IndexPlusOne, Length).


check_items4(_, [], Length, Length).
check_items4([SequenceHead|SequenceTail], ItemsToCheck, Index, Length) :-
  select_n(Index, ItemsToCheck, RemainingItemsToCheck, SequenceHead),
  IndexPlusOne is Index + 1,
  !, check_items4(SequenceTail, RemainingItemsToCheck, IndexPlusOne, Length).

%
% count(+Needle, +Haystack, ?Amount)
% Count the amount of needles (single item) in a haystack (list).
% Can be used to verify the amount of needles in a haystack.
% Green cuts were used to optimize.
%

% There will be nothing to be found in an empty list.
count(_, [], 0).
% If we found a needle, increase a counter.
count(Needle, [Needle|HaystackRest], Amount) :-
  count(Needle, HaystackRest, OtherAmount), !,
  Amount is OtherAmount + 1.
% Current item is not a needle, skip.
count(Needle, [SomeHay|HaystackRest], Amount) :-
  Needle \= SomeHay, !,
  count(Needle, HaystackRest, Amount).

