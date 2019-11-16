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




choose_move(Board1, Board2, Player) :-
    (
        test(Board1, Board2),
        game_over(Board2, Player),
        write('\n'),
        write(winner)
    );
    (
        test(Board1, Board2),
        (
            write(ssss),
            oponnent(Player, Opponent),
            \+ game_over(Board2, Opponent),
            write('\n'),
            write(notwinner)
        )
    ).

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

testBoard(
	[
		[white,     black,     empty],
		[black,     white,     black],
		[empty,     empty,     empty]
	]
).