writeSpace(N) :- N=:=0; (write(' '), writeSpace(N-1)).

printLine([]).
printLine([A|B]):-
	(A = empty, write(' .'), printLine(B));
	(A = white, write(' O'), printLine(B));
	(A = black, write(' X'), printLine(B));
	(A = whiteCone, write(' o'), printLine(B));
	(A = blackCone, write(' x'), printLine(B)).


display_game(Board) :-  nl, display_game(Board,0), nl.
display_game([A|B], N) :-
	nl,
	writeSpace(N),
	printLine(A), 
	(
		list_empty(B);
		display_game(B,N+1)
	), !.

