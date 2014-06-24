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


event(Who, What, Where) :-
	member(Who, [aramis, pathos, athos]),
	member(What, [clean, meet, duel]),
	member(Where, [hotel, jardin, estate]).



%event_not(Who, What, Where) :- event(Who, What, Where), !, fail.
%event_not(_, _, _).
%event_not(Who, What, Where) :- not(event(Who, What, Where)).
event_not(Who, What, Where) :- 
	event(Who, _, _),
	event(OtherWho, What, Where),
	Who \= OtherWho.
event_not(Who, What, Where) :- 
	event(_, What, _),
	event(Who, OtherWhat, Where), 
	What \= OtherWhat.
event_not(Who, What, Where) :- 
	event(_, _, Where),
	event(Who, What, OtherWhere), 
	Where \= OtherWhere.


event(Who, What, Where, Events) :-
	member([Who, What, Where], Events).

event_not(Who, What, Where, Events) :- 
	not(member([Who, What, Where], Events)).




who_did_what_where([AramisAction, AramisPlace],
                   [PathosAction, PathosPlace],
                   [AthosAction, AthosPlace]) :-

	event(_, _, jardin, Events),
	event(_, _, hotel, Events),
	event(_, _, estate, Events),

	length(Events, 3), !,

	event(_, clean, _, Events),
	event(_, meet, _, Events),
	event(_, duel, _, Events),

	event(athos, AthosAction, AthosPlace, Events),
	event(pathos, PathosAction, PathosPlace, Events),
	event(aramis, AramisAction, AramisPlace, Events),
/*		
	AramisAction \= PathosAction,
	AramisPlace \= PathosPlace,
	PathosAction \= AthosAction,
	PathosPlace \= AthosPlace,
	AthosAction \= AramisAction,
	AthosPlace \= AramisPlace,
*/	
	% "If either Aramis or Athos was in the Jardin, 
	%   then someone cleaned his musket in the hotel."
	% (RJ | AJ ) -> CH
	% -(RJ | AJ) | CH
	% (-RJ & -AJ) | CH
	( % or
	  ( % and
	    event_not(aramis, _, jardin, Events), 
	    event_not(athos, _, jardin, Events)); 
	  event(_, clean, hotel, Events)
	),
	
	% "Neither was Pathos involved in a duel 
	%   nor did the duel take place in the Jardin."
	% -PD & - DJ
	( % and
	  event_not(pathos, duel, _, Events),
  	  event_not(_, duel, jardin, Events)
	),
	
	% "Aramis lost his musket some days ago, 
	%   and he was certainly not in the hotel."
	% -RC & -RH
	( % and
	  event_not(aramis, clean, _, Events),
	  %event_not(aramis, duel, _, Events),
	  event_not(aramis, _, hotel, Events)
	),
	
	% "If Pathos cleaned his musket 
	%   then Constance has not been to the Jardin."
	% PC -> MJ
	% -PC | -MJ
	( % or
  	  event_not(pathos, clean, _, Events);
  	  event_not(_, meet, jardin, Events)
	),
	
	% "Cardinal Richelieu has been seen in Villier's estate 
	%   if and only if Pathos was in Villier's estate."
	% DE <-> PE
	% (DE -> PE) & (PE -> DE)
	% (-DE | PE) & (-PE | DE)
	( % and
	  ( % or
  	    event_not(_, duel, estate, Events);
	    event(pathos, _, estate, Events)
	  ), ( % or
	    event_not(pathos, _, estate, Events);
  	    event(_, duel, estate, Events)
	  )
	),
	
	% "Women are not allowed in Treville's Hotel."
	(
	  event_not(_, meet, hotel, Events)
	),

	true.

	

/*
% OLD BACKUP BELOW

event(Who, What, Where) :-
	member(Who, [aramis, pathos, athos]),
	member(What, [clean, meet, duel]),
	member(Where, [hotel, jardin, estate]).



%event_not(Who, What, Where) :- event(Who, What, Where), !, fail.
%event_not(_, _, _).
%event_not(Who, What, Where) :- not(event(Who, What, Where)).
event_not(Who, What, Where) :- 
	event(Who, _, _),
	event(OtherWho, What, Where),
	Who \= OtherWho.
event_not(Who, What, Where) :- 
	event(_, What, _),
	event(Who, OtherWhat, Where), 
	What \= OtherWhat.
event_not(Who, What, Where) :- 
	event(_, _, Where),
	event(Who, What, OtherWhere), 
	Where \= OtherWhere.

/*
% "If either Aramis or Athos was in the Jardin, 
%   then someone cleaned his musket in the hotel."
%event(_, musket, hotel) :-
%	event(aramis, _, jardin); event(athos, _, jardin).
event_not(aramis, _, jardin) :- event_not(_, clean, hotel).
event_not(athos, _, jardin) :- event_not(_, clean, hotel).

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
*/


who_did_what_where([AramisAction, AramisPlace],
                   [PathosAction, PathosPlace],
                   [AthosAction, AthosPlace]) :-

	event(athos, AthosAction, AthosPlace),
	event(pathos, PathosAction, PathosPlace),
	event(aramis, AramisAction, AramisPlace),

	AramisAction \= PathosAction,
	AramisPlace \= PathosPlace,
	PathosAction \= AthosAction,
	PathosPlace \= AthosPlace,
	AthosAction \= AramisAction,
	AthosPlace \= AramisPlace,
	
	% "If either Aramis or Athos was in the Jardin, 
	%   then someone cleaned his musket in the hotel."
	% (RJ | AJ ) -> CH
	% -(RJ | AJ) | CH
	% (-RJ & -AJ) | CH
	( % or
	  ( % and
	    event_not(aramis, _, jardin), 
	    event_not(athos, _, jardin)); 
	  event(_, clean, hotel)
	),
	
	% "Neither was Pathos involved in a duel 
	%   nor did the duel take place in the Jardin."
	% -PD & - DJ
	( % and
	  event_not(pathos, duel, _),
  	  event_not(_, duel, jardin)
	),
	
	% "Aramis lost his musket some days ago, 
	%   and he was certainly not in the hotel."
	% -RC & -RH
	( % and
	  event_not(aramis, clean, _),
	  %event_not(aramis, duel, _),
	  event_not(aramis, _, hotel)
	),
	
	% "If Pathos cleaned his musket 
	%   then Constance has not been to the Jardin."
	% PC -> MJ
	% -PC | -MJ
	( % or
  	  event_not(pathos, clean, _);
  	  event_not(_, meet, jardin)
	),
	
	% "Cardinal Richelieu has been seen in Villier's estate 
	%   if and only if Pathos was in Villier's estate."
	% DE <-> PE
	% (DE -> PE) & (PE -> DE)
	% (-DE | PE) & (-PE | DE)
	( % and
	  ( % or
  	    event_not(_, duel, estate);
	    event(pathos, _, estate)
	  ), ( % or
	    event_not(pathos, _, estate);
  	    event(_, duel, estate)
	  )
	),
	
	% "Women are not allowed in Treville's Hotel."
	(
	  event_not(_, meet, hotel)
	),

	true.

	*/