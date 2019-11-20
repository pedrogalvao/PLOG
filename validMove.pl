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


valid_moves(Board, Player, ListOfMoves) :-
	findall(Move, is_valid_move(Move, Board), ListOfMoves).

