writeSpace(N) :- N=:=0; (write(' '), writeSpace(N-1)).

printLine([]).
printLine([A|B]):-
	(
		ground(A),
		(
			(A = -1, write('X | '), printLine(B));
			(write(A), write(' | '), printLine(B))
		)
	);
	(
		write('  | '), printLine(B)
	)
	.


display_game(Board) :-  
	nth0(1,Board, ColSums),
	nth0(0,Board, RowSums),
	nth0(2,Board, Cells),
	nl, write(' '),
	display_colsums(ColSums),
	display_rows(RowSums, Cells), nl, !.


display_rows([],[]).
display_rows([S1|S],[A|B]) :-
	nl,
	(
		(
			S1 = -1,
			write(' ')
		);
		write(S1)
	),
	write(' | '), 
	printLine(A), nl,
	display_rows(S,B), !.

display_colsums([]).
display_colsums([A|B]):-
	(A = -1, write('    '), display_colsums(B));
	(write('   '), write(A), display_colsums(B)).
