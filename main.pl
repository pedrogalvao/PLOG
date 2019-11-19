:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/utils.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/play.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/display.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/validMove.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/game_over.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/expand.pl').
:- use_module(library(lists)).

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
		Input = '2' ;
		Input = '3' -> aboutMenu, mainMenu;
		Input = '4';

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).


gameModeMenu:-
	clearConsole,
	printGameModeMenu,
	get_char(Input),
	get_char(_),
	(
		Input = '1' -> write('not implemented yet');
		Input = '2' -> write('not implemented yet');
		Input = '3' -> play, mainMenu;
		Input = '4' ;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).

printMainMenu:-
	write('___________________________________________'), nl,
	write('|              << TAIGO >>                |'), nl,
	write('|_________________________________________|'), nl,
	write('|                                         |'), nl,
	write('|         1. Play                         |'), nl,
	write('|         1.How to Play                   |'), nl,
	write('|         2. Exit                         |'), nl,
	write('|                                         |'), nl,
	write('|_________________________________________|'), nl,
	write('Choose an option:'), nl.


printGameModeMenu:-
	write('___________________________________________'), nl,
	write('|       << Choose Game Mode >>            |'), nl,
	write('|_________________________________________|'), nl,
	write('|                                         |'), nl,
	write('|         1. Player vs Player             |'), nl,
	write('|         2. Player vs Computer           |'), nl,
	write('|         3. Computer vs Computer         |'), nl,
	write('|         2. Exit                         |'), nl,
	write('|                                         |'), nl,
	write('|_________________________________________|'), nl,
	write('Choose an option:'), nl.

howToPlay :- 
	write('__________________________________________________________________'), nl,
	write('|                      << How to play >>                         |'), nl,
	write('|________________________________________________________________|'), nl,
	write('|   O Taigo é um jogo de tabuleiro para dois jogadores inventado |'), nl,
	write('| por Néstor Romeral Andrés.                                     |'), nl,
	write('|   Cada um dos jogadores possui inicialmente vinte peças        |'), nl,
	write('| hexagonais e dez cones. Cada jogador tem uma cor atribuída,    |'), nl,
	write('| sendo que as peças hexagonais têm a cor dos dois jogadores e os|'), nl,
	write('| cones têm apenas a cor de cada jogador. O jogo consiste em     |'), nl,
	write('| dispor as peças a mesa até que um dos jogadores consiga formar |'), nl,
	write('| uma fila com cinco peças adjacentes.                           |'), nl,
	write('|   Eventualmente, durante o jogo, serão criados buracos entre os|'), nl,
	write('| hexágonos que devem ser preenchidos com cones. Quando o jogo   |'), nl,
	write('| demora tempo suficiente, os jogadores podem ficar sem cones da |'), nl,
	write('| sua cor. Nessa situação, serão forçados a jogar com os cones do|'), nl,
	write('| adversário.                                                    |'), nl,
	write('|                                                                |'), nl,
	write('|    Comandos:                                                   |'), nl,
	write('|   Ao jogar o jogador deve especificar as coordenadas dos       |'), nl,
	write('| espaços onde desejar posicionar suas peças. Deve especificar   |'), nl,
	write('| numeros inteiros indicando primeiro a coordenada da parte      |'), nl,
	write('| branca e depois a da parte preta.                              |'), nl,
	write('|________________________________________________________________|'), nl,
	write('Choose an option:'), nl.