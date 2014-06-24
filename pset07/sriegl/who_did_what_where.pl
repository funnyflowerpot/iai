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



% To find all (here: one) possible solutions that meet the given constraints,
% we create a "database" Events, i.e. a data structure. During that particular 
% spring evening, three events happened and these events are listed in the 
% database Events. Each event contains a name, an action and a place, in this 
% order. The database is assumed to be correct and validity is checked by 
% proving the given constraints above, formulated in propositional logic only
% represented by conjunctions, disjunctions and negations.
% 
who_did_what_where([AramisAction, AramisPlace],
                   [PathosAction, PathosPlace],
                   [AthosAction, AthosPlace]) :-

	member([_, _, jardin], Events),
	member([_, _, hotel], Events),
	member([_, _, estate], Events),

	% Until here, we have set the minimal number of entries in our database
	% Events. With length/2 we are additionally limiting the maximal number
	% of entries. Otherwise new entries might be added by not fitting
	% constraints below and we might get caught in a loop.
	length(Events, 3), 
	
	% If we would have to backtrack beyond this point, then we won't find a
	% solution. Therefore, we have a green cut here.
	!,

	member([_, clean, _], Events),
	member([_, meet, _], Events),
	member([_, duel, _], Events),

	member([athos, AthosAction, AthosPlace], Events),
	member([pathos, PathosAction, PathosPlace], Events),
	member([aramis, AramisAction, AramisPlace], Events),

	% We must not include \=/2 predicates here to guarantee different actions
	% and places for each musketeer. Since each person is contained in the
	% database, each person must appear at least once and due to the limited 
	% amount of entries in the database, each person can only appear once at
	% most. The same holds for actions and places.

	% Convert natural language statements into propositional logic statements.
	% Since these statements are ought to act as constraints within this
	% predicate, we have to represent implications as disjunction including 
	% negated antecedent.

	% "If either Aramis or Athos was in the Jardin, 
	%   then someone cleaned his musket in the hotel."
	% (RJ | AJ ) -> CH
	% -(RJ | AJ) | CH
	% (-RJ & -AJ) | CH
	( % or
	  ( % and
	    not(member([aramis, _, jardin], Events)), 
	    not(member([athos, _, jardin], Events))); 
	  member([_, clean, hotel], Events)
	),
	
	% "Neither was Pathos involved in a duel 
	%   nor did the duel take place in the Jardin."
	% -PD & - DJ
	( % and
	  not(member([pathos, duel, _], Events)),
  	  not(member([_, duel, jardin], Events))
	),
	
	% "Aramis lost his musket some days ago, 
	%   and he was certainly not in the hotel."
	% -RC & -RH
	( % and
	  not(member([aramis, clean, _], Events)),
	  %not(member([aramis, duel, _], Events)),
	  not(member([aramis, _, hotel], Events))
	),
	
	% "If Pathos cleaned his musket 
	%   then Constance has not been to the Jardin."
	% PC -> MJ
	% -PC | -MJ
	( % or
  	  not(member([pathos, clean, _], Events));
  	  not(member([_, meet, jardin], Events))
	),
	
	% "Cardinal Richelieu has been seen in Villier's estate 
	%   if and only if Pathos was in Villier's estate."
	% DE <-> PE
	% (DE -> PE) & (PE -> DE)
	% (-DE | PE) & (-PE | DE)
	( % and
	  ( % or
  	    not(member([_, duel, estate], Events));
	    member([pathos, _, estate], Events)
	  ), ( % or
	    not(member([pathos, _, estate], Events));
  	    member([_, duel, estate], Events)
	  )
	),
	
	% "Women are not allowed in Treville's Hotel."
	(
	  not(member([_, meet, hotel], Events))
	),

	% yeah, we did it B-)
	true.

	