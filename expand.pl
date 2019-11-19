addColumnLeft(Board, Result) :-
	(
		Board = [],
		Result = []
	);
	(
		Board = [FirstLine | AuxBoard],
		FirstLine2 = [empty|FirstLine],
		addColumnLeft(AuxBoard, AuxResult),
		Result = [FirstLine2|AuxResult]
	).


addColumnRight(Board, Result) :-
	(
		Board = [],
		Result = []
	);
	(
		Board = [FirstLine | AuxBoard],
		reverse(FirstLine, FirstLineRev),
		reverse([empty|FirstLineRev], FirstLine2),
		addColumnRight(AuxBoard, AuxResult),
		Result = [FirstLine2|AuxResult]
	).

addRowTop(Board, Result) :-		
	Board = [FirstLine|_],
	length(FirstLine, K),
	fillList(empty, K, NewLine),
	Result = [NewLine|Board].
	
addRowBottom(Board, Result) :-		
	Board = [FirstLine|_],
	length(FirstLine, K),
	fillList(empty, K, NewLine),
	reverse(Board,RevBoard),
	reverse([NewLine|RevBoard], Result).
	

expand(Board, Result) :- 
	(
		(
			(
				nth0(0, Board, FirstLine),
				(
					\+ member(white, FirstLine) ,
					\+ member(black, FirstLine)
				),
				PreResult2 = Board
			);
			(
				addRowTop(Board,PreResult1),
				addRowTop(PreResult1,PreResult2)
			)
		),
		(
			last(Board, LastLine),
			length(Board, K),
			K2 is K-1,
			nth0(K2, Board, LastLine2),
			(
				(
					\+ member(white, LastLine) ,
					\+ member(black, LastLine)
				),
				(
					\+ member(white, LastLine2) ,
					\+ member(black, LastLine2)
				),
				PreResult4 = PreResult2
			);
			(
				(
					\+ member(white, LastLine) ,
					\+ member(black, LastLine)
				),
				(
					member(white, LastLine2) ;
					member(black, LastLine2)
				),
				addRowBottom(PreResult2, PreResult4)
			);
			(
				(
					member(white, LastLine) ;
					member(black, LastLine)
				),
				addRowBottom(PreResult2, PreResult3),
				addRowBottom(PreResult3, PreResult4)
			)
		),
		(
			(
				columnN(Board, 1, FirstColumn),
				(
					\+ member(white, FirstColumn),
					\+ member(black, FirstColumn)
				),
				PreResult6 = PreResult4
			);
			(
				addColumnLeft(PreResult4,PreResult5),
				addColumnLeft(PreResult5,PreResult6)
			)
		),
		(
			nth0(0, Board, FirstLine),
			length(FirstLine, K),
			columnN(Board, K, LastColumn),
			K2 is K-1,
			write(LastColumn),
			columnN(Board, K2, LastColumn2),
			write(LastColumn2),
			(
				write(LastColumn),
				(
					\+ member(white, LastColumn),
					\+ member(black, LastColumn)
				),
				(
					\+ member(white, LastColumn2),
					\+ member(black, LastColumn2)
				),
				Result = PreResult6
			);		
			(
				write(LastColumn),
				write(LastColumn2),
				(
					\+ member(white, LastColumn),
					\+ member(black, LastColumn)
				),
				(
					member(white, LastColumn2);
					member(black, LastColumn2)
				),
				addColumnRight(PreResult6, Result)
			);
			(
				(
					member(white, LastColumn);
					member(black, LastColumn)
				),
				addColumnRight(PreResult6, PreResult7),
				addColumnRight(PreResult7, Result)
			)
		)
	), !.


