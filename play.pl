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
        opponent(Player, Opponent),
        aligned_free(Board, Opponent, 4),
        Value is -1000,
        !
    );
    (
        aligned_free(Board, Player, 4),
        Value is 4,
        !
    );
    (
        aligned_free(Board, Player, 3),
        Value is 3,
        !
    );
    (
        aligned_free(Board, Player, 2),
        Value is 2,
        !
    );
    Value is 0.

compare_values(Board1, Board2, Player) :-
    value(Board1, Player, Value1), 
    value(Board2, Player, Value2), 
    Value1 >= Value2.

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
    Move = [[X1, Y1],[X2, Y2]].

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
            move(Move, Board, PreNextBoard),
            (
                add_cone(PreNextBoard, Player, NextBoard);
                PreNextBoard = NextBoard
            ),
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


startPvC :- 
    emptyBoard(InitialBoard),
    continuePvC(InitialBoard).

continuePvC(Board) :-
    display_game(Board), nl,
    write('Player white, choose your move'), nl,
    getPlayerMove(Move),
    (
        (
            move(Move, Board, PreNextBoard),
            (
                add_cone(PreNextBoard, Player, NextBoard);
                PreNextBoard = NextBoard
            ),
            (
                (
                    game_over(NextBoard, Winner),
                    display_game(NextBoard),
                    nl, write('Game Over'), nl,
                    write('Winner:'),
                    write(Winner)
                );
                (
                    expand(NextBoard, NextBoard2)
                )
            )
        );
        (
            nl, write('Invalid move, try again'), nl,
            continuePvC(Board)
        )
    ), !,
    display_game(NextBoard2),
    write('Wait for computer to choose a move...'),
    choose_move(NextBoard2, 0, ComputerMove),
    move(ComputerMove, NextBoard2, NextBoard3),
    (
        (
            game_over(NextBoard3, Winner),
            display_game(NextBoard3),
            nl, write('Game Over'), nl,
            write('Winner:'),
            write(Winner)
        );
        (
            (
                add_cone(NextBoard3, black, NextBoard4);
                NextBoard4 = NextBoard3
            ),
            expand(NextBoard4, NextBoard5),
            continuePvC(NextBoard5)
        )
    ).






