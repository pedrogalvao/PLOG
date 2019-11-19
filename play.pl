value(Board, Player, Value) :-
    (
        game_over(Board, Player),
        Value is 1000,
        !
    );
    (
        oponnent(Player, Opponent),
        game_over(Board, Oponnent),
        Value is -1000,
        !
    );
    (
        member(Line,Board),
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
    write(comp1_)
    value(Board1, Player, Value1), 
    value(Board2, Player, Value2), 
    Value1 >= Value2,
    write(comp2_).

choose_move(Board1, Board2, Player) :-
    valid_moves(Board1, Player, ListOfMoves),
    member(Board2,ListOfMoves),
    write(a),
    forall(member(N, ListOfMoves), compare_values(Board2, N, Player)).

play() :- 
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
