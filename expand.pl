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
				nth0(1, Board, SecondLine),
				(
					\+ member(white, FirstLine) ,
					\+ member(black, FirstLine)
				),
				(
					\+ member(white, SecondLine) ,
					\+ member(black, SecondLine)
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
			K2 is K-2,
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
				columnN(Board, 2, SecondColumn),
				(
					\+ member(white, FirstColumn),
					\+ member(black, FirstColumn)
				),
				(
					\+ member(white, SecondColumn),
					\+ member(black, SecondColumn)
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
			K1 is K,
			columnN(Board, K1, LastColumn),
			K2 is K-1,
			columnN(Board, K2, LastColumn2),
			(
				(
					\+ member(white, LastColumn),
					\+ member(black, LastColumn)
				),
				write(ali),
				(
					\+ member(white, LastColumn2),
					\+ member(black, LastColumn2)
				),
				write(aqui),
				Result = PreResult6
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


