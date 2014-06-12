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

prime(X) :- .... .