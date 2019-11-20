is_valid_move(Move, Board) :-
	Move = [[X1, Y1],[X2,Y2]],
	nth0(Y1, Board, Line1),
	nth0(X1, Line1, Elem1),
	Elem1 = empty,
	(
		((X2 is X1-1; X2 is X1+1), (Y2 is Y1));
		((X2 is X1), (Y2 is Y1-1; Y2 is Y1+1));
		((X2 is X1-1), (Y2 is Y1+1));
		((X2 is X1+1), (Y2 is Y1-1))
	),
	nth0(Y2, Board, Line2),
	nth0(X2, Line2, Elem2),
	Elem2 = empty.

move(Move, Board, NewBoard) :-
	is_valid_move(Move, Board),
	Move = [[X1, Y1],[X2,Y2]],
	nth0(Y1, Board, Line1),
	replace(Line1,X1,white,NewLine1),
	replace(Board, Y1, NewLine1, PreNewBoard),
	nth0(Y2, PreNewBoard, Line2),
	replace(Line2,X2,black,NewLine2),
	replace(PreNewBoard, Y2, NewLine2, NewBoard).



validMove([[empty, empty]],[[white, black]]).
validMove([[empty, empty]],[[black, white]]).

validMove([[empty],[empty]],[[white], [black]]).
validMove([[empty], [empty]],[[black], [white]]).

validMove(
	[
		[X, empty], 
		[empty, Y]
	], 
	[
		[X, white], 
		[black, Y]
	]
).


validMove(
	[
		[X, empty], 
		[empty, Y]
	], 
	[
		[X, black], 
		[white, Y]
	]
).




validMove(Board1, Board2) :-
	\+ list_empty(Board1),
	write(a),
	(
		write(b),
		append(X,Y,Board1), 
		\+ list_empty(X),
		\+ list_empty(Y), 
		append(X,Z,Board2),
		\+ list_empty(Z), 
		validMove(Y,Z)
	) ;
	(
		append(X,Z,Board1), 
		\+ list_empty(X),
		\+ list_empty(Z), 
		append(Y,Z,Board2), 
		\+ list_empty(Y), 
		validMove(X,Y)
	) ;
	(
		write(c),
		transpose(Board1, Board1T),
		append(X,Y,Board1T), 
		\+ list_empty(X),
		\+ list_empty(Y), 
		append(X,Z,Board2T),
		\+ list_empty(Z), 
		validMove(Y,Z),
		transpose(Board2T, Board2)
	) ;
	(
		transpose(Board1, Board1T),
		append(X,Z,Board1T), 
		\+ list_empty(X),
		\+ list_empty(Z), 
		append(Y,Z,Board2T), 
		\+ list_empty(Y), 
		validMove(X,Y),
		transpose(Board2T, Board2)
	).


is_valid(Board, Result) :-
	(
		append(A, B, Board),
		B = [Line | C],
		append(D, E, Line),
		append(F, [empty,empty], D),
		(
			append(F, [white, black], R);
			append(F, [black, white], R)
		),
		append(R, E, Line2),
		append(A, [Line2], R2),
		append(R2, C, Result)
	);
	(
		transpose(Board, BoardT),
		append(A, B, BoardT),
		B = [Line | C],
		append(D, E, Line),
		append(F,[empty,empty],D),
		(
			append(F, [white, black], R);
			append(F, [black, white], R)
		),
		append(R, E, Line2),
		append(A, [Line2], R2),
		append(R2, C, RR),
		transpose(RR, Result)
	).
/*
valid_moves(Board, Player, ListOfMoves) :-
	findall(Result, is_valid(Board, Result), ListOfMoves).*/

valid_moves(Board, Player, ListOfMoves) :-
	findall(Move, is_valid_move(Move, Board), ListOfMoves).

