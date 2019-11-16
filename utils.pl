list_empty([]).
list_empty([[]]).

transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :- transpose_1st_col(Matrix, Row, RestMatrix),
                                 transpose(RestMatrix, Rows).
transpose_1st_col([], [], []).
transpose_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- transpose_1st_col(Rows, Hs, Ts).

lenght([],0).
lenght(List, N) :-
	List = [_|List2],
	lenght(List2, N2),
	N is N2+1.

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


oponnent(Player, Oponnent) :-
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
		[black,     white,     white,      white,     white,     white,     empty,     empty],
		[black,     black,     black,      black,     white,     black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).

emptyBoard(
	[
		[empty,     empty,     empty],
		[empty,     empty,     empty],
		[empty,     empty,     empty]
	]
).

onePieceBoard(
	[
		[empty,     empty,     empty],
		[black,     empty,     empty],
		[empty,     empty,     empty]
	]
).