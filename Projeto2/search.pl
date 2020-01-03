
findSolution(Board, Cells) :-
    nth0(0, Board, ColSums),
    nth0(1, Board, RowSums),
    write(a),
    Vars = [
        A1, A2,
        B1, B2
    ],
    write(a),
    domain(Vars,-1,3), 
    sums2([ColSums, RowSums, Cells]),
    labeling([],Vars),
    Cells = [
        [A1, A2],
        [B1, B2]
    ].


rowSum2(Row, Sum) :-
    write('rowSum2'),
    (
        write(' AAA1 '), nl,
        Row = [A | Rest],
        A #= -1,
        restSum2(Rest, Sum),
        labeling([], [A , Sum])
    );
    (
        write(' AAA2 '), nl,
        Row = [A | Rest],
        A #\= -1,
        rowSum2(Rest, Sum),
        labeling([], [A , Sum])
    ).



restSum2([A], B) :- 
    write('LAST restSum '),
    A = -1,
    B = 0.

restSum2(Rest, Sum) :-
    write('RESTSUM2 '),
    length(Rest, Len),
    write('Len '),
    write(Len),nl,
    Len > 1,
    (
        (
        write(' BBB1 '), nl,
            Row = [A | Rest],
            A = -1,
            Sum = 0
        );
        (
            write(' BBB2 '), nl,
            Rest = [A | Rest2],
            A in 1..3,
            Sum2 in 0..10,
            restSum2(Rest2, Sum2),
            Sum #= Sum2 + A,
            Sum2 #= Sum - A,
            labeling([], [Sum2|Rest])            
        )
    ).


solveRow(Sum, Row) :-
    Sum = empty;
    (
        A in -1..3,
        B in -1..3,
        C in -1..3,
        D in -1..3,
        E in -1..3,
        rowSum2([A, B, C, D, E], Sum),
        Row = [A, B, C, D, E]
    ).



































