chooseMove(Board1, Board2, Player) :-
    (
        test(Board1, Board2),
        checkWinner(Board2, Player),
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
            \+ checkWinner(Board2, Opponent),
            write('\n'),
            write(notwinner)
        )
    ).

play(Initial, Final, Player) :-
    expand(Initial, Expanded),
    chooseMove(Expanded, Next, Player),
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