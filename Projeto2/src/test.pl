testSolve(BoardSize, ExecutionTime) :-
    statistics(walltime,_),
    generateEmptyBoard(BoardSize, Board), solve(Board),
    statistics(walltime, [_, ExecutionTime]), !.

testSolve(BoardSize, 0, 0).
testSolve(BoardSize, TotalExecutionTime, NumberOfTests) :-
    testSolve(BoardSize, ExecutionTime1),
    N2 is NumberOfTests - 1,
    testSolve(BoardSize, Total2, N2),
    TotalExecutionTime is ExecutionTime1 + Total2.



testSolve2(BoardSize, ExecutionTime) :-
    statistics(walltime,_),
    generateEmptyBoard(BoardSize, Board), solve(Board),
    statistics(walltime, [_, ExecutionTime]), !.

testSolve2(BoardSize, 0, 0).
testSolve2(BoardSize, TotalExecutionTime, NumberOfTests) :-
    testSolve2(BoardSize, ExecutionTime1),
    N2 is NumberOfTests - 1,
    testSolve2(BoardSize, Total2, N2),
    TotalExecutionTime is ExecutionTime1 + Total2,    
    Mean is TotalExecutionTime/NumberOfTests.
