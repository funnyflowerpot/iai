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
  writeln('############################################################'),
  writeln('# max list length changed, revert back to 8 before release #'),
  writeln('############################################################'),
  between(0,5,N),
  magic_sequence(N,S),
  writeln(N:S),
  fail.

doit.

%-------------------------------------------------
% magic sequence of length N
% magic_sequence(+N,-Sequence)



magic_sequence(Length, Sequence) :-
  length(Sequence, Length),
  contains_ints(Sequence, Length),
  check_items(Sequence, Sequence, 0).

contains_ints([], _).
contains_ints([SequenceHead|SequenceTail], Length) :-
  between(0, Length, SequenceHead), !,
  contains_ints(SequenceTail, Length).

% Index: What to be counted.
% CurrentAmount: Amount of what to be counted.
check_items([], _, _).
check_items([CurrentAmount|ItemsLeft], Sequence, Index) :-
  count(Index, Sequence, CurrentAmount),
%  writef('%w, %w, %w\n', [[CurrentAmount|ItemsLeft], Sequence, Index]),
  OtherIndex is Index + 1, !,
  check_items(ItemsLeft, Sequence, OtherIndex).



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


