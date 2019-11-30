rowSum(Row, Sum) :-
    (
        Row = [black | Rest],
        restSum(Rest, Sum)
    );
    (
        Row = [A | Rest],
        \+ (A = black),
        rowSum(Rest, Sum)
    ), !.

restSum(Rest, Sum) :-
    (
        Rest = [black |_],
        Sum is 0,
        !
    );
    (
        Rest = [A | Rest2],
        restSum(Rest2, Sum2),
        Sum is A + Sum2,
        !
    ).

checkRowSumK(B, K, Sums) :-
    nth0(K, Sums, SumK),
    (
        (
            SumK = empty,
            write('empty \n'),
            !
        );
        (
            nth0(3, Board, B),
            nth0(K, B, RowK),
            write(SumK),
            rowSum(RowK, SumK),
            write(' sum ok \n')
        )
    ),
    length(B, Length),
    Lim is Length - 1,
    (
        K >= Lim;
        (
            K2 is K + 1,
            checkRowSumK(B, K2, Sums)
        )
    ).

checkRowSums(Board) :-
    nth0(0, Board, Sums),
    nth0(2, Board, B),
    checkRowSumK(B, 0, Sums), 
    !.

checkColumnSums(Board) :-
    nth0(1, Board, Sums),
    nth0(2, Board, B),
    transpose(B, BT),
    checkRowSumK(BT, 0, Sums), 
    !.

checkSums(Board) :-
    checkRowSums(Board),
    checkColumnSums(Board).

