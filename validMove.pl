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
		write(b),
		transpose(Board1, Board1T),
		transpose(Board2, Board2T),
		append(X,Y,Board1T), 
		\+ list_empty(X),
		\+ list_empty(Y), 
		append(X,Z,Board2T),
		\+ list_empty(Z), 
		validMove(Y,Z)
	) ;
	(
		write(c),
		transpose(Board1, Board1T),
		transpose(Board2, Board2T),
		append(X,Z,Board1T), 
		\+ list_empty(X),
		\+ list_empty(Z), 
		append(Y,Z,Board2T), 
		\+ list_empty(Y), 
		write(X),
		write(Y),
		write(Z),
		validMove(X,Y)
	) .
