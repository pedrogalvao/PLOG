writeSpace(N) :- N=:=0; (write(' '), writeSpace(N-1)).

printLine([]).
printLine([A|B]):-
	(A = empty, write('  '), printLine(B));
	(A = white, write(' O'), printLine(B));
	(A = black, write(' X'), printLine(B));
	(A = whiteCone, write(' o'), printLine(B));
	(A = blackCone, write(' x'), printLine(B)).

display_game(Board) :- display_game(Board,0).
display_game([A|B], N) :-
	write('\n'),
	writeSpace(N),
	printLine(A), 
	(
		list_empty(B);
		display_game(B,N+1)
	).


initialBoard([[white]]).
initialBoard([[empty,empty,empty],[empty,white,empty],[empty,empty,empty]]).
