checkWinner([[white, white, white, white, white]], white).
checkWinner([[black, black, black, black, black]], black).


aligned(Line, Color, Number) :- aligned(Line, Color, Number, Number).
aligned(Line, Color, Number, 0).
aligned(Line, Color, Number, K) :-
    (
        Line = [Color | SubLine],
        K2 is K-1,
        aligned(SubLine, Color, Number, K2)
    );
    (
        Line = [_ | SubLine],
        aligned(SubLine, Color, Number, Number)
    ).

line5(Line, Color) :-
    (
        append([white, white, white, white, white], _, Line),
        Color = white
    );    
    (
        append([black, black, black, black, black], _, Line),
        Color = black
    );
    (
        Line = [_|Rest],
        line5(Rest, Color)
    ).

checkLines(Board, Winner) :-
    Board = [FirstLine | OtherLines],
    (
        line5(FirstLine, Winner);
        (
            \+ list_empty(OtherLines),
            checkLines(OtherLines, Winner)
        )
    ).

game_over(Board, Winner) :-
	\+ list_empty(Board),
	(
		checkLines(Board, Winner)
	) ;
	(
		transpose(Board, BoardT),
		checkLines(BoardT, Winner)
	).
