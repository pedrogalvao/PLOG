list_empty([]).
list_empty([[]]).

transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :- transpose_1st_col(Matrix, Row, RestMatrix),
                                 transpose(RestMatrix, Rows).
transpose_1st_col([], [], []).
transpose_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- transpose_1st_col(Rows, Hs, Ts).

exampleBoard(
	[
		[empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty],
		[empty,     white,     empty,      empty,     empty,     empty,     white,     empty],
		[black,     white,     white,      empty,     black,     white,     empty,     empty],
		[black,     blackCone, black,      black,     whiteCone, black,     empty,     empty],
		[white,     white,     empty,      white,     black,     black,     white,     empty],
		[empty,     empty,     empty,      black,     empty,     white,     empty,     empty],
		[empty,     empty,     empty,      empty,     black,     empty,     empty,     empty]
	]
).
