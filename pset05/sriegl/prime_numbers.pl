/*
Write a predicate prime(P) which enumerates the prime numbers less than 120.
Implement the sieve of Eratosthenes

Hint:
- you need one cut, to make the program tail recursive

- discuss the color of the cut operator

Remember:
A program is tail recursive, if the recursive subgoal is in the last position of the
last (active) clause and there are no choice points (alternatives) in subgoals left to it.
To force this condition you may add a cut immediately before this subgoal,
Remember:
A green cut does not change the solution set,
a read cut does!
Check if the system can reach the position of the cut at backtracking.

Hint: The system will never reach a subgoal at backtracking
if right to the subgoal there is another subgoal which has an infinite
set of solutions.

Hints: you may need the following helper predicates

- prime(+KnownListOfPrimes, -PrimeNumber)
  which returns the biggest already known prime number or extends the list with the next
  unknown prime number. Initialize KnownListOfPrimes with [2].

- check_prime(+PrimeNumber, +KnownListOfPrimes)
  which checks that PrimeNumber is not a multiple of one of the elements of KnownListOfPrimes.

- next(+N, -N1)
  which enumerates all natural numbers (up to 120) bigger than a given N

- Use the arithmetic operator 'mod' to compute the modulus.

- Make sure that the program terminates with false for calls like prime(4)

You can solve the problem within 18 lines of code (heads + subgoals) 

*/



% prime(-TheNumber)
% User interface to enumerate all prime numbers up to 120.
prime(TheNumber) :-
	prime([2], TheNumber).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prime(+KnownListOfPrimes, -PrimeNumber)
% "returns the biggest already known prime number or extends the list with the
% next unknown prime number. Initialize KnownListOfPrimes with [2]."
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Additional notes for this predicate:
% - KnownListOfPrimes is sorted descendingly (e.g.: [11,7,5,3,2]).
% - KnownListOfPrimes is meant to grow by attaching new prime numbers as heads.
% - The way this predicate works can be visualized in the following way,
%   where prime/2 in the first column refers to the second definition of the
%   predicate and the prime/2 in the second column reforse to the first.
%
%
%   prime(      [2], PN)  -->  prime(      [2], 2)  -->  Output: "PN = 2"
%         |
%         V
%   prime(    [3,2], PN)  -->  prime(    [3,2], 3)  -->  Output: "PN = 3"
%         |
%         V
%   prime(  [5,3,2], PN)  -->  prime(  [5,3,2], 5)  -->  Output: "PN = 5"
%         |
%         V
%   prime([7,5,3,2], PN)  -->  prime([7,5,3,2], 7)  -->  Output: "PN = 7"
%
%
% General remark on readability: "[BiggestPrime|OtherPrimes]" denotes the list
% of all known prime numbers at the moment this predicate was called. During
% the last three lines, NewNumber could be identified to be a proper new prime
% number. So "[NewNumber|[BiggestPrime|OtherPrimes]]" denotes the list of all
% known prime numbers by know.


% If the number in question (PrimeNumber) appears in the list of known prime
% numbers, the number in question is a prime number.
prime([PrimeNumber|_], PrimeNumber).

% Find the next number (NewNumber) that is bigger than the last known prime 
% number (BiggestPrime). Check if NewNumber is a prime number. Consider
% NewNumber to be the definitive answer for the next bigger prime number after
% BiggestPrime by using the cut. Present NewNumber as next prime number and
% recurse to find the next prime number in the same manner.
prime([BiggestPrime|OtherPrimes], PrimeNumber) :-
	% With biggest known prime as lower bound, iterate through all numbers 
	% under 120 as NewNumber.
	next(BiggestPrime, NewNumber),
	% Check if NewNumber is a prime number, utilizing all known prime numbers,
	% which is [BiggestPrime|OtherPrimes]. If this step proves to be wrong, 
	% the next number (NewNumber) yielded by next/2 will be used and step will
	% get repeated. After this line, NewNumber is warranted to be a prime 
	% number.
	check_prime(NewNumber, [BiggestPrime|OtherPrimes]), 
	% Remove all other choice points, which means: Take all instances found
	% by now as last values. This is a green cut, since no former or solutions
	% for this recursion step of prime/2 will be cut out. This cut is 
	% necessary to avoid backtracking from a recursed call of prime/2.
	!,
	% The next line will be considered two times.
	% * This first consideration of the next line utilizes the first defintion 
	%   of prime/2 and will always result in a successful proof: PrimeNumber
	%   is not yet instantiated, and the list of known prime numbers as first
	%   argument is non-empty, therefore "prime([PrimeNumber|_], PrimeNumber)."
	%   is true and PrimeNumber gets instantiated to NewNumber, which actually
	%   is the prime number that was found in the last three lines. Because
	%   by now all conjuncts could be proven to be true, PrimeNumber will be
	%   handed back up to the inital call of prime/1 as a valid prime number.
	%   Then we will consider the next line for the second time.
	% * The second consideration of the next line utilizes the second 
	%   definition of prime/2, so basically the recursion is happening. For
	%   this second consideration PrimeNumber is still not instantiated. This
	%   allows us to do a call of prime/2 like the call of prime/2 that led
	%   us here, except we have a new element in the list of known prime
	%   numbers. (See "general remark on readability" and diagram above.)
	prime([NewNumber|[BiggestPrime|OtherPrimes]], PrimeNumber).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check_prime(+PrimeNumber, +KnownListOfPrimes)
% "checks that PrimeNumber is not a multiple of one of the elements of 
% KnownListOfPrimes."
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% True by definition, if no prime numbers are given (empty list). Necessary
% as recursion anchor.
check_prime(_, []).
% Check that a given number (PrimeNumber) is not a multiple of the first
% prime number (KnownPrime) of a list of prime numbers. Repeat this step 
% (recursion) for all following numbers (KnownListOfPrimesTail).
check_prime(PrimeNumber, [KnownPrime|KnownListOfPrimesTail]) :-
	% x is a multiple of y if a modulo divison results in 0.
	PrimeNumber mod KnownPrime =\= 0,
	% Iterate through rest of list.
	check_prime(PrimeNumber, KnownListOfPrimesTail).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% next(+N, -N1)
% "which enumerates all natural numbers (up to 120) bigger than a given N"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get all N1 for which it holds that N < N1 <= 120.
next(N, N1) :-
	% Requirement for N1 is to be bigger than N, so we need a helper variable,
	% specifying a minimum for between/3.
	NPlusOne is N + 1,
	% between/3 is true, if following statement holds:
	% first argument <= third argument <= second argument
	between(NPlusOne, 120, N1).
