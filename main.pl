:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/utils.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/play.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/display.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/validMove.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/game_over.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/expand.pl').
:- use_module(library(lists)).
:- use_module(library(random)).

clearConsole:-
	clearConsole(40), !.

clearConsole(0).
clearConsole(N):-
	nl,
	N1 is N-1,
	clearConsole(N1).

mainMenu:-
	printMainMenu,
	get_char(Input),
	get_char(_),
	(
		Input = '1' -> gameModeMenu;
		Input = '2' -> howToPlay;
		Input = '3';

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).


gameModeMenu:-
	printGameModeMenu,
	get_char(Input),
	get_char(_),
	(
		Input = '1' -> startPvP;
		Input = '2' -> startPvC;
		Input = '3' ;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).

howToPlay :-
	printHowToPlay,
	get_char(_),
	mainMenu.


printMainMenu:-
	clearConsole,
	write('___________________________________________'), nl,
	write('|                                         |'), nl,
	write('|              << TAIGO >>                |'), nl,
	write('|_________________________________________|'), nl,
	write('|                                         |'), nl,
	write('|         1. Play                         |'), nl,
	write('|         2. How to Play                  |'), nl,
	write('|         3. Exit                         |'), nl,
	write('|                                         |'), nl,
	write('|_________________________________________|'), nl,
	write('Choose an option:'), nl.


printGameModeMenu:-
	clearConsole,
	write('___________________________________________'), nl,
	write('|                                         |'), nl,
	write('|       << Choose Game Mode >>            |'), nl,
	write('|_________________________________________|'), nl,
	write('|                                         |'), nl,
	write('|         1. Player vs Player             |'), nl,
	write('|         2. Player vs Computer           |'), nl,
	write('|         3. Exit                         |'), nl,
	write('|                                         |'), nl,
	write('|_________________________________________|'), nl,
	write('Choose an option:'), nl.

printHowToPlay :- 
	clearConsole,
	write('__________________________________________________________________'), nl,
	write('|                                                                |'), nl,
	write('|                      << How to play >>                         |'), nl,
	write('|________________________________________________________________|'), nl,
	write('|   O Taigo e um jogo de tabuleiro para dois jogadores inventado |'), nl,
	write('| por Nestor Romeral Andres.                                     |'), nl,
	write('|   Cada um dos jogadores possui inicialmente vinte pecas        |'), nl,
	write('| hexagonais e dez cones. Cada jogador tem uma cor atribuida,    |'), nl,
	write('| sendo que as pecas hexagonais tem a cor dos dois jogadores e os|'), nl,
	write('| cones tem apenas a cor de cada jogador. O jogo consiste em     |'), nl,
	write('| dispor as pecas a mesa ate que um dos jogadores consiga formar |'), nl,
	write('| uma fila com cinco pecas adjacentes.                           |'), nl,
	write('|   Eventualmente, durante o jogo, serao criados buracos entre os|'), nl,
	write('| hexagonos que devem ser preenchidos com cones. Quando o jogo   |'), nl,
	write('| demora tempo suficiente, os jogadores podem ficar sem cones da |'), nl,
	write('| sua cor. Nessa situacao, serao forcados a jogar com os cones do|'), nl,
	write('| adversario.                                                    |'), nl,
	write('|                                                                |'), nl,
	write('|    Comandos:                                                   |'), nl,
	write('|   Ao jogar o jogador deve especificar as coordenadas dos       |'), nl,
	write('| espacos onde desejar posicionar suas pecas. Deve especificar   |'), nl,
	write('| numeros inteiros indicando primeiro as coordenadas da parte    |'), nl,
	write('| branca e depois a da parte preta. Cada numero deve ser escrito |'), nl,
	write('| com exatamente 2 algarismos. As coordenadas sao contadas a     |'), nl,
	write('| do canto superior esquerdo do tabuleiro comecando em 0.        |'), nl,
	write('|________________________________________________________________|'), nl,
	write('Press enter to go back to the main menu'), nl.