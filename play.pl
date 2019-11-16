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
            (
                (Player = black, Opponent = white);
                (Player = white, Opponent = black)
            ),
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