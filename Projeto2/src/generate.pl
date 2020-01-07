generateUndefRowAux(2, Row) :- Row = [-1,-1].
generateUndefRowAux(Size, Row) :-
    K is Size-1,
    generateUndefRowAux(K, Row2),
    append(Row2, [Num], Row).
    
generateUndefRow(Size, Row) :-
    generateUndefRowAux(Size, Row2), !,
    random_permutation(Row2, Row).


generateRow(Size, Row) :- generateRow(Size,Row,0).
generateRow(Size, Row, Size).
generateRow(Size, Row, K) :-
    random(1,4,Num),
    K2 is K+1,
    generateRow(Size, Row2, K2),
    append(Row2, [Num], Row).



generateUndefBoard(Size, [], 0).

generateUndefBoard(Size, Board) :-
    generateUndefRow(Size, Row),
    K2 is Size-1,
    generateUndefBoard(Size, Board2, K2),
    append([Row], Board2, Board), 
    transpose(Board, BoardT),
    blackCellsOk(BoardT);    
    generateUndefBoard(Size, Board).

generateUndefBoard(Size, Board, K) :-
    (        
        generateUndefRow(Size, Row),
        K2 is K-1,
        generateUndefBoard(Size, Board2, K2),
        append([Row], Board2, Board)
    ),!.


defineRow([]).
defineRow(Row) :-
    Row = [A|Rest],
    (
        ground(A);
        random(1,4,A)
    ),
    defineRow(Rest).

defineBoard([]).
defineBoard(Board) :-
    Board = [FirstRow|Rest],
    defineRow(FirstRow),
    defineBoard(Rest).

blackCellsOk([]).
blackCellsOk([A|Rest]) :-
    rowBlackCellsOk(A, 2),
    blackCellsOk(Rest).

rowBlackCellsOk([], 0).
rowBlackCellsOk([A|B], K) :-
    K >= 0,
    length([A|B], L), L>0,
    (
        ground(A),
        A = -1,
        K > 0,
        K2 is K-1,
        rowBlackCellsOk(B, K2)
    );
    (
        var(A),
        rowBlackCellsOk(B, K)
    ).

emptyRow(0,[]).
emptyRow(Size,[A|Rest]):-
    K is Size - 1,
    emptyRow(K, Rest).

emptyCells(Size, Cells) :- emptyCells(Size, Cells, Size).
emptyCells(Size, [], 0).
emptyCells(Size, Cells, K) :-
    (        
        emptyRow(Size, Row),
        K2 is K-1,
        emptyCells(Size, Cells2, K2),
        append([Row], Cells2, Cells)
    ),!.


generateBoard(Size, Board) :-
    generateUndefBoard(Size, Cells),
    defineBoard(Cells),
    getRowSums(Cells, RowSums),
    transpose(Cells, CellsT),
    getRowSums(CellsT, ColSums),
    Board = [RowSums, ColSums, Cells].

generateEmptyBoard(Size, Board) :-
    generateBoard(Size, CompleteBoard),
    CompleteBoard = [RowSums,ColSums,_],
    emptyCells(Size,Cells),
    Board = [RowSums,ColSums,Cells].



