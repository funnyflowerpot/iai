%--------------------------------------------------------
% Who Did What Where
% (thanks to Manuel Ebert)
%--------------------------------------------------------
% In one particular chapter of Dumas' novel
% three events happened simultaneously
% on spring evening in 1643:
%
% - Someone was cleaning his musket, 
% - another one met Constance Bonacieux and 
% - yet another one had a duel with Cardinal Richelieu.
%
% One of these events happened in the Hotel Treville, 
% one in the Jardin du Luxembourg and 
% one in Geroge Villier's estate.
%
% If either Aramis or Athos was in the Jardin, 
%   then someone cleaned his musket in the hotel.
% Neither was Pathos involved in a duel 
%   nor did the duel take place in the Jardin.
% Aramis lost his musket some days ago, 
%   and he was certainly not in the hotel.
% If Pathos cleaned his musket 
%   then Constance has not been to the Jardin.
% Cardinal Richelieu has been seen in Villier's estate 
%   if and only if Pathos was in Villier's estate.
% Women are not allowed in Treville's Hotel.
%
% Implement a predicate who_did_what(Aramis, Athos, Pathos) 
% that will instantiate each Person with a list containing
%    his action and the place he happened to be at 
%    (e.g. Athos = [duel, jardin] etc.)
% according to the information given above.
%
% Hints:
% - Use duel, meet, clean as the names for the actions
%   and hotel, jardin, estate as the names for the places
% - Use ; for or, negations and equations in the predicate.
% - All the constraints should be mentioned
%   in this predicate.
% - Besides who_did_what(X, Y, Z), you will (at most) also
%   need two predicates enumerating actions and places.
%--------------------------------------------------------



event(aramis, _, _).
event(pathos, _, _).
event(athos, _, _).
event(_, clean, _).
event(_, meet, _).
event(_, duel, _).
event(_, _, hotel).
event(_, _, jardin).
event(_, _, estate).


event_not(Who, What, Where) :- event(Who, What, Where), !, fail.
event_not(_, _, _).


% "If either Aramis or Athos was in the Jardin, 
%   then someone cleaned his musket in the hotel."
%event(_, musket, hotel) :-
%	event(aramis, _, jardin); event(athos, _, jardin).
event_not(aramis, _, jardin) :- event_not(_, musket, hotel).
event_not(athos, _, jardin) :- event_not(_, musket, hotel).

% "Neither was Pathos involved in a duel 
%   nor did the duel take place in the Jardin."
event_not(pathos, duel, _).
event_not(_, duel, jardin).

% "Aramis lost his musket some days ago, 
%   and he was certainly not in the hotel."
event_not(aramis, clean, _).
%event_not(aramis, duel, _).
event_not(aramis, _, hotel).

% "If Pathos cleaned his musket 
%   then Constance has not been to the Jardin."
event_not(_, meet, jardin) :- event(pathos, clean, _).

% "Cardinal Richelieu has been seen in Villier's estate 
%   if and only if Pathos was in Villier's estate."
% (problematic iff, try to find a workaround)
% It follows, that iff Pathos was in estate, he was duelling. Speaking for
% the estate, we can only have a duelling Pathos, or: no Pathos and no duel.
% Because of the iff we will not have only a Pathos or only a duel without
% the respective other one (again: valid for estate). 
% We can not express "a; b." in Prolog. But we can exclude invalid facts.
event_not(pathos, clean, estate).
event_not(pathos, meet, estate).
event_not(aramis, duel, estate).
event_not(athos, duel, estate).

% "Women are not allowed in Treville's Hotel."
event_not(_, meet, hotel).


who_did_what_where([AramisAction, AramisPlace],
                   [PathosAction, PathosPlace],
                   [AthosAction, AthosPlace]) :-
	event(athos, AthosAction, AthosPlace),
	event(pathos, PathosAction, PathosPlace),
	event(aramis, AramisAction, AramisPlace),
%	not(event_not(aramis, AramisAction, AramisPlace)),
%	not(event_not(pathos, PathosAction, PathosPlace)),
%	not(event_not(athos, AthosAction, AthosPlace)),
	AramisAction \= PathosAction,
	AramisPlace \= PathosPlace,
	PathosAction \= AthosAction,
	PathosPlace \= AthosPlace,
	AthosAction \= AramisAction,
	AthosPlace \= AramisPlace.
	
	