is_valid_move(Move, Board) :-
	Move = [[X1, Y1],[X2,Y2]],
	nth0(Y1, Board, Line1),
	nth0(X1, Line1, Elem1),
	Elem1 = empty,
	(
		((X2 is X1-1; X2 is X1+1), (Y2 is Y1));
		((X2 is X1), (Y2 is Y1-1; Y2 is Y1+1));
		((X2 is X1-1), (Y2 is Y1+1));
		((X2 is X1+1), (Y2 is Y1-1))
	),
	nth0(Y2, Board, Line2),
	nth0(X2, Line2, Elem2),
	Elem2 = empty.

move(Move, Board, NewBoard) :-
	is_valid_move(Move, Board),
	Move = [[X1, Y1],[X2,Y2]],
	nth0(Y1, Board, Line1),
	replace(Line1, X1, white, NewLine1),
	replace(Board, Y1, NewLine1, PreNewBoard),
	nth0(Y2, PreNewBoard, Line2),
	replace(Line2, X2, black, NewLine2),
	replace(PreNewBoard, Y2, NewLine2, NewBoard).


valid_moves(Board, Player, ListOfMoves) :-
	findall(Move, is_valid_move(Move, Board), ListOfMoves).

 count([],0).

count([_|Tail], N) :-
    count(Tail, N1), N is N1 + 1.

higherValues([], B, A, B ).

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

evaluate_moves([], Board, Player, []).
evaluate_moves(ListOfMoves, Board, Player, MovesValues) :-
    append([X],Rest,ListOfMoves),
    move(X, Board, Board2),
    value(Board2, Player, Value),
    evaluate_moves(Rest, Board, Player, RestMovesValues),
    append([[X,Value]], RestMovesValues, MovesValues), !.

get_ListOfMoves(Board1, Player, Move) :-
    valid_moves(Board1, Player, ListOfMoves),
    evaluate_moves(ListOfMoves, Board1, Player, MovesValues),
    higherValues(MovesValues, AfterMovesValues),
    count(AfterMovesValues, N),
    random(0, N, Y),
    nth0(Y, AfterMovesValues, Move1),
    append([Move], _, Move1).

choose_move(Board, Level, Move) :-
    get_ListOfMoves(Board, black, Move).

add_cone(Board, Color, Result) :- 
    (
        nth0(X, Board, Line),
        nth0(Y, Line, Elem),
        Elem = empty,
        X2 is X+1,
        Y2 is Y+1,
        X3 is X-1,
        Y3 is Y-1,
        nth0(X2, Board, Line2),
        nth0(Y, Line2, Elem2),
        Elem2 \= empty,
        nth0(Y3, Line2, Elem3),
        Elem3 \= empty,
        nth0(X3, Board, Line3),
        nth0(Y, Line3, Elem4),
        Elem4 \= empty,
        nth0(Y2, Line3, Elem5),
        Elem5 \= empty,
        nth0(X2, Line, Elem6),
        Elem6 \= empty,
        nth0(X3, Line, Elem7),
        Elem7 \= empty,
        cone(Color, Cone),
        replace(Line, Y, Cone, NewLine),
        replace(Board, X, NewLine, Result)
    ).
