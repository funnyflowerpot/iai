/*
in Prolog list structures will be printed in a
simplified notation
enter the simplified version of the following list
as second argument of a two placed predicate 'test_list'
enter the number of the exercise as first argument:

Example:

 0. [a | [[b | []] | []]]
*/

% 0. [a | [[b | []] | []]]
test_list(0, [a, [b]]).

% Simplify the following cases:

% 1. [a | [b | [c | [123 | Rest]]]]
test_list(1, [a,b,c,123|_Rest]). 
% 2. [[a | []] | [b | [c | [] ]]]
test_list(2, [a, b, c]).
% 3. [a | [[b | []] | [c | Rest]]]
test_list(3, [a , [b | []] | [c | Rest]].
/*
Write down in the same way
the complete 'head-tail' notation
for the following lists:
*/

% 4. [a,b,c,[c,b,a]]

% 5. [2,a,1]

% 6. [a,[b,[c,[d,[],[]]]]]