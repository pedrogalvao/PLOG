value(Board, Player, Value) :-
    (
        game_over(Board, Player),
        Value is 1000,
        !
    );
    (
        opponent(Player, Opponent),
        game_over(Board, Opponent),
        Value is -1000,
        !
    );
    (
        member(Line, Board),
        aligned(Line, Player, 4),
        Value is 4,
        !
    );
    (
        transpose(Board, BoardT),
        member(Line,BoardT),
        aligned(Line, Player, 4),
        Value is 4,
        !
    );
    (
        member(Line,Board),
        aligned(Line, Player, 3),
        Value is 3,
        !
    );
    (
        transpose(Board, BoardT),
        member(Line,BoardT),
        aligned(Line, Player, 3),
        Value is 3,
        !
    );
    (
        member(Line,Board),
        aligned(Line, Player, 2),
        Value is 2,
        !
    );
    (
        transpose(Board, BoardT),
        member(Line,BoardT),
        aligned(Line, Player, 2),
        Value is 2,
        !
    );
    Value is 0.

compare_values(Board1, Board2, Player) :-
    write(comp1_),
    value(Board1, Player, Value1), 
    value(Board2, Player, Value2), 
    Value1 >= Value2,
    write(comp2_).

choose_move(Board1, Board2, Player) :-
    valid_moves(Board1, Player, ListOfMoves),
    member(Board2,ListOfMoves),
    forall(member(N, ListOfMoves), compare_values(Board2, N, Player)).

play :- 
    emptyBoard(A),
    play(A, B, white).

play(Initial, Final, Player) :-
    expand(Initial, Expanded),
    choose_move(Expanded, Next, Player),
    display_game(Next), !,
    (
        (
            Player = black,
            play(Next, Final, white)
        );
        (
            Player = white,
            play(Next, Final, black)
        )
    ).

getPlayerMove(Move):-
    write('x1='),
    getNumber(X1),
    get_char(_),
    write('y1='),
    getNumber(Y1),
    get_char(_),
    write('x2='),
    getNumber(X2),
    get_char(_),
    write('y2='),
    getNumber(Y2),
    get_char(_),
    Move = [[X1, Y1],[X2, Y2]],
    write(Move).

getNumber(N):-
    (
        get_char(C1),
        get_char(C2),
        (
            member(C1,['0','1','2','3','4','5','6','7','8','9']),
            (
                member(C2,['0','1','2','3','4','5','6','7','8','9']),
                number_chars(N, [C1,C2])
            );
            (
                \+member(C2,['0','1','2','3','4','5','6','7','8','9']),
                number_chars(N, [C1])
            )
        )
    ).

startPvP :- 
    emptyBoard(InitialBoard),
    continuePvP(InitialBoard, white).

continuePvP(Board, Player) :-
    display_game(Board), nl,
    write('Player '), write(Player), write(', choose your move'), nl,
    getPlayerMove(Move),
    (
        (
            move(Move, Board, NextBoard),
            (
                (
                    game_over(NextBoard, Winner),
                    display_game(NextBoard),
                    nl, write('Game Over'), nl,
                    write('Winner:'),
                    write(Winner)
                );
                (
                    expand(NextBoard, NextBoard2),
                    opponent(Player, NextPlayer),
                    continuePvP(NextBoard2, NextPlayer)
                )
            )
        );
        (
            nl, write('Invalid move, try again'), nl,
            continuePvP(Board, Player)
        )
    ).


evaluate_moves([], Board, Player, []).
evaluate_moves(ListOfMoves, Board, Player, MovesValues) :-
    append([X],Rest,ListOfMoves),
    move(X, Board, Board2),
    value(Board2, Player, Value),
    evaluate_moves(Rest, Board, Player, RestMovesValues),
    append([[X,Value]], RestMovesValues, MovesValues), !.



higherValues([], B, A, B).
higherValues(MovesValues, AfterMovesValues) :- higherValues(MovesValues, AfterMovesValues, -1000, []).
higherValues(MovesValues, BestMovesValues, MinValue, BestMovesValuesUntilNow) :-
    append([X], Rest, MovesValues),
    append(_, [Xval], X),
    (
        (
            MinValue > Xval,
            higherValues(Rest, BestMovesValues, MinValue, BestMovesValuesUntilNow)
        );
        (
            Xval is MinValue,
            append([X],  BestMovesValuesUntilNow,  BestMovesValuesUntilNow2),
            higherValues(Rest, BestMovesValues, MinValue,  BestMovesValuesUntilNow2)
        );
        (
            Xval > MinValue,
            BestMovesValuesUntilNow2 = [X],
            MinValue2 = Xval,
            higherValues(Rest, BestMovesValues, MinValue2, BestMovesValuesUntilNow2)
        )
    ).
