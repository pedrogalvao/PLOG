rowSum(Row, Sum) :-
    (
        Row = [-1 | Rest],
        restSum(Rest, Sum)
    );
    (
        Row = [A | Rest],
        \+ (A = -1),
        rowSum(Rest, Sum)
    ), !.

restSum(Rest, Sum) :-
    (
        Rest = [-1 | Rest2],
        Sum is 0,
        positive(Rest2)
    );
    (
        Rest = [A | Rest2],
        restSum(Rest2, Sum2),
        Sum is A + Sum2
    ).

positive([]).
positive([A|B]) :- 
    A > 0,
    positive(B).


rowDomainOk(Row) :- rowDomainOk(Row, 2).
rowDomainOk([], K).
rowDomainOk([A|B], K) :-
    (
        A = -1,
        K > 0,
        K2 is K-1,
        rowDomainOk(B, K2)
    );
    (
        A in 1..6,
        rowDomainOk(B, K)
    ).
    

checkRowSumK(B, K, Sums) :-
    nth0(K, Sums, SumK),
    nth0(3, Board, B),
    nth0(K, B, RowK),
    (
        (
            SumK = empty,
            rowDomainOk(RowK,2)
        );
        (
            rowSum(RowK, SumK),
            rowDomainOk(RowK,2)
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


getRowSums([], []).
getRowSums([Row1|Rest], [Sum1|RestSum]) :-
    rowSum(Row1, Sum1),
    getRowSums(Rest,RestSum).



checkRowSums(Board) :-
    nth0(0, Board, Sums),
    nth0(2, Board, B),
    checkRowSumK(B, 0, Sums), 
    !.

checkColumnSums(Board) :-
    nth0(1, Board, Sums),
    nth0(2, Board, B),
    transpose(B, BT),
    checkRowSumK(BT, 0, Sums).

checkSums(Board) :-
    checkRowSums(Board),
    checkColumnSums(Board).

