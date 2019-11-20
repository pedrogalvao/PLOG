aligned(Board, Color, K) :-
    (
        member(Line, Board),
        aligned_in_row(Line, Color, K)
    );
    (
        transpose(Board, BoardT),
        member(Line, BoardT),
        aligned_in_row(Line, Color, K)
    );
    (
        all_diagonals(Board, BoardD),
        member(Line, BoardD),
        aligned_in_row(Line, Color, K)
    ).

aligned_free(Board, Color, K) :-
    (
        member(Line, Board),
        aligned_free_in_row(Line, Color, K)
    );
    (
        transpose(Board, BoardT),
        member(Line, BoardT),
        aligned_free_in_row(Line, Color, K)
    );
    (
        all_diagonals(Board, BoardD),
        member(Line, BoardD),
        aligned_free_in_row(Line, Color, K)
    ).

aligned_free_in_row(Line, Color, Number) :-
    (
        append([empty], SubLine, Line),
        aligned_in_row(SubLine, Color, Number)
    );
    (
        append(SubLine, [empty], Line), 
        aligned_in_row(SubLine, Color, Number)
    );
    (
        Line = [X | SubLine],
        X \=empty,
        aligned_free_in_row(SubLine, Color, Number)
    ).


aligned_in_row(Line, Color, Number) :- aligned_in_row(Line, Color, Number, Number).
aligned_in_row(Line, Color, Number, 0).
aligned_in_row(Line, Color, Number, K) :-
    (
        Line = [Piece | SubLine],
        color(Piece, Color),
        K2 is K-1,
        aligned_in_row(SubLine, Color, Number, K2)
    );
    (
        Line = [_ | SubLine],
        aligned_in_row(SubLine, Color, Number, Number)
    ).

game_over(Board, Winner) :-
	\+ list_empty(Board),
	aligned(Board, Winner, 5).
