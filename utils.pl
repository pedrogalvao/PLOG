list_empty([]).
list_empty([[]]).

replace(List, Idx, With, ListOut) :-
   append(Before, [_Discard|Rest], List),
   length(Before,Idx),
   append(Before, [With|Rest], ListOut).

fillList(Element, 1, List) :- List = [Element].
fillList(Element, Number, List) :-
	\+ Number < 0,
	(
		N2 is Number - 1,
		fillList(Element, N2, List2),
		append([Element],List2,List)
	).

rowN([H|_],1,H):-!.
rowN([_|T],I,X) :-
    I1 is I-1,
    rowN(T,I1,X).

columnN([],_,[]).
columnN([H|T], I, [R|X]):-
   rowN(H, I, R), 
columnN(T,I,X).

diagonal(Board, Number, Diagonal) :- diagonal(Board, Number, Diagonal, []).

diagonal([], Number, Diagonal, Diagonal).

diagonal(Board, Number, Diagonal, Diagonal) :- Number < 0.

diagonal(Board, Number, Diagonal, AuxDiag) :-
	Board = [FirstLine|Rest],
	length(FirstLine,Len), 
	(
		(
			Number >= Len,
			AuxDiag2 = AuxDiag
		);
		(
			Number < Len,
			nth0(Number, FirstLine, Elem), 
			append([Elem], AuxDiag, AuxDiag2)
		)
	),
	Number2 is Number-1,
	diagonal(Rest, Number2, Diagonal, AuxDiag2).



all_diagonals(Board, Diagonals) :- 
	Board = [FirstLine|_],
	length(FirstLine, Len),
	N is Len + Len - 2,
	all_diagonals(Board, Diagonals, N, []), !.

all_diagonals(Board, Diagonals, N, Diagonals) :- N < 0.
all_diagonals(Board, Diagonals, N, AuxDiags) :-
	diagonal(Board, N, Diag),
	append([Diag], AuxDiags, AuxDiags2),
	N2 is N-1,
	all_diagonals(Board, Diagonals, N2, AuxDiags2).

color(Piece, Color) :-
	(
		Piece = white,
		Color = white
	);
	(
		Piece = whiteCone,
		Color = white
	);
	(
		Piece = black,
		Color = black
	);
	(
		Piece = blak,
		Color = blackCone
	).


opponent(Player, Opponent) :-
	(
		(Player = black, Opponent = white);
		(Player = white, Opponent = black)
	).


exampleBoard(
	[
		[empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty],
	    [empty,     white,     empty,      empty,     empty,     empty,     white,     empty],
		[black,     white,     white,      empty,     black,     white,     empty,     empty],
		[black,     black,     black,      black,     white,     black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).
exampleBoard2(
	[
		[empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty],
		[empty,     white,     empty,      empty,     white,     black,     white,     empty],
		[black,     white,     white,      empty,     black,     white,     empty,     empty],
		[black,     blackCone, black,      black,     whiteCone, black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).
exampleBoard3(
	[
		[black,     empty,     empty,      empty,     empty,     empty,     empty,     empty],
		[white,     white,     empty,      empty,     empty,     empty,     white,     empty],
		[black,     white,     white,      empty,     black,     white,     empty,     empty],
		[black,     blackCone, black,      black,     whiteCone, black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).
exampleBoard4(
	[
		[empty,     black,     empty,      empty,     empty,     empty,     empty,     empty],
		[white,     white,     empty,      empty,     empty,     empty,     white,     empty],
		[black,     white,     white,      empty,     black,     white,     empty,     empty],
		[black,     blackCone, black,      black,     whiteCone, black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).

smallBoard(
	[
		[black,     empty,     empty],
		[black,     whiteCone, black],
		[white,     white,     black]
	]
).

smallBoard2(
	[
		[empty,     black,     empty,     empty,     empty],
		[empty,     white,     empty,     white,     empty],
		[black,     black,     white,     empty,     empty],
		[black,     whiteCone, black,     empty,     empty],
		[white,     white,     black,     black,     white]
	]
).

smallBoard3(
	[
		[empty,     empty,     empty],
		[empty,     whiteCone, black],
		[white,     white,     black]
	]
).

exampleBoardW(
	[
		[empty,     black,     empty,      empty,     empty,     empty,     empty,     empty],
		[white,     white,     empty,      empty,     empty,     empty,     white,     empty],
		[black,     white,     white,      white,     empty,     white,     empty,     empty],
		[black,     black,     black,      black,     whiteCone, black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     white,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     black,      empty,     black,     empty,     empty,     empty]
	]
).

emptyBoard(
	[
		[empty,     empty],
		[empty,     empty]
	]
).

onePieceBoard(
	[
		[empty,     empty,     empty],
		[black,     empty,     empty],
		[empty,     empty,     empty]
	]
).


testBoard(
	[
		[white,     black,     empty],
		[black,     white,     black],
		[empty,     empty,     empty]
	]
).