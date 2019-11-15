addColumnLeft(Board, Result) :-
	(
		Board = [],
		Result = []
	);
	(
		Board = [FirstLine | AuxBoard],
		FirstLine2 = [empty|FirstLine],
		addEmptyColumnLeft(AuxBoard, AuxResult),
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
		addEmptyColumnRight(AuxBoard, AuxResult),
		Result = [FirstLine2|AuxResult]
	).

addRowTop(Board, Result) :-		
	Board = [FirstLine|_],
	lenght(FirstLine, K),
	fillList(empty, K, NewLine),
	Result = [NewLine|Board].
	
addRowBottom(Board, Result) :-		
	Board = [FirstLine|_],
	lenght(FirstLine, K),
	fillList(empty, K, NewLine),
	reverse(Board,RevBoard),
	reverse([NewLine|RevBoard], Result).
	

expand(Board, Result) :- 
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
		(
			last(Board, LastLine),
			(
				\+ member(white, LastLine) ,
				\+ member(black, LastLine)
			),
			PreResult4 = PreResult2
		);
		(
			addRowBottom(PreResult2,PreResult3),
			addRowBottom(PreResult3,PreResult4)
		)
	),
	(
		(
			columnN(Board, 1, FirstColumn),
			(
				\+ member(white, FirstColumn) ,
				\+ member(black, FirstColumn)
			),
			Result = PreResult4
		);
		(
			addColumnLeft(PreResult4,PreResult5),
			addColumnLeft(PreResult5,Result)
		)
	).

