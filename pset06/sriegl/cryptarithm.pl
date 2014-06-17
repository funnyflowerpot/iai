/*
Professor Earth, looking out of his observatory, told his friend Professor Math, "Out there are uncountable planets and stars... (sensing the latter's boredom) Now, did you know that the other planets of our solar system which you can see, are such that if you replace the letters of five of them by digits 0 through 9, then the sum of four of them is equal to the fifth one?" Professor Math leapt out of boredom and began to scribble furiously in his notebook.
(from http://www.contestcen.com/rithms.htm)

[code]
      M A R S
    V E N U S
  S A T U R N
  U R A N U S
-------------
N E P T U N E
[/code]

a) Define a predicate

   planets([A,E,M,N,P,R,S,T,U,V])

that computes a solution (assigning the digits to the letters)
such that the this summation task is correct.

assume that different letters represent different digits and leading digits are not zero.

Use generate and test as a first approach.

Check the efficency with the predicate 'time'.

b) Try to define an improved program 'planets_i'.

Try to minimize the number of inferences,
but try to use principles, which may be applied to similar problems! 
Do not use special properties of this problem.

Hint:
select(?X,+L,-L1) 
selects an element X from the list L and binds L1 to L whithout X. 
may be used to select a digit from a set of available digits
to solve the 'all different' condition.
*/

% you code goes here


% unsorted_equal(+Source, +Template)
unsorted_equal([], []).
unsorted_equal([SourceHead|SourceTail], TemplateList) :-
  select(SourceHead, TemplateList, ReducedTemplateList),
  unsorted_equal(SourceTail, ReducedTemplateList).



planets([A,E,M,N,P,R,S,T,U,V]) :-
	
  % one and only one digit for one and only one letter
  unsorted_equal([A,E,M,N,P,R,S,T,U,V], [1,2,3,4,5,6,7,8,9,0]),

  % no leading zeros
  M > 0, V > 0, S > 0, U > 0, N > 0,
	
  % representing equation  	
  0 is                             M*1000 + A*100 + R*10 + S*1 +
                         V*10000 + E*1000 + N*100 + U*10 + S*1 +
              S*100000 + A*10000 + T*1000 + U*100 + R*10 + N*1 +
              U*100000 + R*10000 + A*1000 + N*100 + U*10 + S*1 -
 (N*1000000 + E*100000 + P*10000 + T*1000 + U*100 + N*10 + E*1).
  

planets_i([A,E,M,N,P,R,S,T,U,V]) :-
  % one and only one digit for one and only one letter
  unsorted_equal([A,E,M,N,P,R,S,T,U,V], [1,2,3,4,5,6,7,8,9,0]),
  % no leading zeros
  M > 0, V > 0, S > 0, U > 0, N > 0,
  % representing equation  	
  0 is A*11100 - E*99001 + M*1000 - N*999809 - P*10000 + R*10020 + S*100003
      + U*100020 + V*10000.
	
	
	
% QUERY planets([A,E,M,N,P,R,S,T,U,V]).
