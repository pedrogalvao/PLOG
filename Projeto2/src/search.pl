
findSolution(Board, Cells) :-
    nth0(0, Board, ColSums),
    nth0(1, Board, RowSums),
    Vars = [
        A1, A2,
        B1, B2
    ],
    domain(Vars,-1,3), 
    sums2([ColSums, RowSums, Cells]),
    labeling([],Vars),
    Cells = [
        [A1, A2],
        [B1, B2]
    ].


rowSum2(Row, Sum) :-
    (
        Row = [A | Rest],
        A #= -1,
        restSum2(Rest, Sum),
        labeling([], [A , Sum])
    );
    (
        Row = [A | Rest],
        A in 1..6,
        rowSum2(Rest, Sum),
        labeling([], [A , Sum])
    ).

anyRow(Row) :- 
    lenght(Row, L),
    MaxSum is L*3,
    Sum in 0..6,
    solveRow(Sum,Row).

any([]).
any(List):-
    List = [A|Rest],
    A in 1..6,
    any(Rest),
    labeling([], [A]).



restSum2([A], B) :- 
    A = -1,
    B = 0.

restSum2(Rest, Sum) :-
    length(Rest, Len),
    Len > 1,
    (
        (
            Rest = [A | Rest2],
            A = -1,
            Sum = 0,
            any(Rest2)
        );
        (
            Rest = [A | Rest2],
            A in 1..6,
            Sum2 in 0..10,
            restSum2(Rest2, Sum2),
            Sum #= Sum2 + A,
            Sum2 #= Sum - A,
            labeling([], [Sum2,A])
        )
    ).


solveRow(Sum, Row) :-
    (
        Sum = -1,
        anyRow(Row)
    );
    (
        Sum \= -1,
        Row = [A|_],
        rowSum2(Row, Sum),
        labeling([], [A])
    ).


solveRows([], []).
solveRows(Sums, Rows):-
    Rows = [Row1|RestRows],
    Sums = [Sum1|RestSums],
    (
        (
            Sum1 \= -1,
            solveRow(Sum1,Row1)
        );
        (
            Sum1 = -1,
            anyRow(Row1)
        )
    ),
    solveRows(RestSums, RestRows).


solve(Board):-
    nth0(0, Board, RowSums),
    nth0(1, Board, ColSums),
    nth0(2, Board, Cells),
    solveRows(RowSums, Cells),
    checkColumnSums(Board),
    display_game(Board).



countGroundVariables(Row) :- countGroundVariables(Row, 0).
countGroundVariables([], 0).
countGroundVariables(Row, Num) :-
    Row = [A | Rest],
    (
        (
            ground(A),
            countGroundVariables(Rest, Num2),
            Num is Num2 + 1
        );
        (
            countGroundVariables(Rest, Num)
        )
    ), !.



chooseRowToSearch([A], [Sa], A, Sa, [], []).
chooseRowToSearch(Rows, Sums, Row, RowSum, UnsolvedRows, UnsolvedSums) :-
    Rows = [A|Rest],
    Sums = [Sa|RestSums],
    chooseRowToSearch(Rest, RestSums, B, Sb, UnsolvedRowsB, UnsolvedSumsB),
    countGroundVariables(A, Na),
    countGroundVariables(B, Nb),
    length(A, LenA),
    (
        (
            Sa = -1,
            Sb \= -1,
            Row = B,
            RowSum = Sb,
            append([A], UnsolvedRowsB, UnsolvedRows),
            append([Sa], UnsolvedSumsB, UnsolvedSums)
        );
        (
            Sa \= -1,
            Sb = -1,
            Row = A,
            RowSum = Sa,
            UnsolvedRows = Rest,
            UnsolvedSums = RestSums
        );
        (
            Na < Nb,
            Row = B,
            RowSum = Sb,
            append([A], UnsolvedRowsB, UnsolvedRows),
            append([Sa], UnsolvedSumsB, UnsolvedSums)
        );
        (
            Na > Nb,
            Row = A,
            RowSum = Sa,
            UnsolvedRows = Rest,
            UnsolvedSums = RestSums
        );
        (
            Sa < Sb,
            Row = B,
            RowSum = Sb,
            append([A], UnsolvedRowsB, UnsolvedRows),
            append([Sa], UnsolvedSumsB, UnsolvedSums)
        );
        (
            Sa >= Sb,
            Row = A,
            RowSum = Sa,
            UnsolvedRows = Rest,
            UnsolvedSums = RestSums
        )
    ).


chooseRowAndSearch([A], [Sa], A, Sa) :- solveRow(Sa, A).
chooseRowAndSearch(Rows, Sums, Row, RowSum) :-
    chooseRowToSearch(Rows, Sums, Row, RowSum, UnsolvedRows, UnsolvedSums), 
    solveRow(RowSum, Row), 
    chooseRowAndSearch(UnsolvedRows, UnsolvedSums, Row2, RowSum2).




solve2(Board) :- 
    nth0(0, Board, RowSums),
    nth0(1, Board, ColSums),
    nth0(2, Board, Cells),
    rowsAndCols(Cells, RC),
    append(RowSums, ColSums, RCSums),
    chooseRowAndSearch(RC, RCSums, Row, RowSum),
    display_game(Board).





rowsAndCols(Cells, List):-
    transpose(Cells, CellsT),
    append(Cells, CellsT, List).














