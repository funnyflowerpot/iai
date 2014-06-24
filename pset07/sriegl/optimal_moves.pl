/*
define a predicate:

  optimal_move(S1,S2)

which is true, if the change from S1 to S2 is an optimal move
for the NIM-game:

  If you can win in S1 you will win with this move!

There are different versions of this game. Implement the version where
the player who must take the last match loses the game.

Hint:

  An optimal move is a correct move (of course),
  which leads to a state
  - from which there is no optimal move for the opponent.
    (We must use negation here and should verify
    that it's save!).
  The situation for the opponent is symmetric, so
  we may define an optimal move for the
  opponent in the same way.

This strategy does not depend on the NIM-game.

You may use the solution of the assignment 'move for the NIM-game'
(with cut and paste).

Adapt it such that legal moves do not lead to
a sequence of only empty heaps.
This corresponds to the rule that the player who
need to take the last match loses the game.

*/

%-------------------------------------------
% please fill in the predicate definitions
%-------------------------------------------
% legal moves (adapted from previous assignment)
% move(+State, -NewState)

%-------------------------------------------
% determine an optimal move
% optimal_move(+State, -NewState) :-

%-------------------------------------------
% check for a terminal state
% terminal_state(+State)

%-------------------------------------------
% maps 'me' to 'you'
% and  'you' to 'me'
% opponent(+Player, -Opponent)

%-------------------------------------------
% play the game: 
% - check for terminal state:
%      if yes print winner and stop
% - else
%   - determine a move for Player 
%       with play_move(+Player, +State, -NewState)
%   - print player and move: State -> NewState
%   - determine opponent
%   - call play with opponent and NewState
%
% play(+Player, +State)

%---------------------------------------------
% determine a move for Player
% play_move(+Player, +State, -NewState)

% first clause: random player 'you':
% - use findall(S, move(State, S), State_List)
%   to compute the successor states for all moves
% - determine the length of State_List with
%   built-in 'length'
% - compute random index with arithmetic function
%    'random'
% - look-up corresponding the element NewState in State_List
%   (you may use 'nth0')
  

% next clauses: optimal player 'me':
% - try to determine an optimal move with 'optimal_move'
% - if not possible determine some move with 'move'