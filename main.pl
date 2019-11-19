:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/utils.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/play.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/display.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/validMove.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/game_over.pl').
:- include('c:/Users/Estudio/Desktop/PLOG/PLOG/expand.pl').
:- use_module(library(lists)).

mainMenu:-
	printMainMenu,
	getChar(Input),
	(
		Input = '1' -> gameModeMenu, mainMenu;
		Input = '2' -> helpMenu, mainMenu;
		Input = '3' -> aboutMenu, mainMenu;
		Input = '4';

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).

printMainMenu:-
	clearConsole,
	write('_________________________________'), nl,
	write('|         << TAIGO >>           |'), nl,
	write('|_______________________________|'), nl,
	write('|                               |'), nl,
	write('|   1. Play                     |'), nl,
	write('|   2. Exit                     |'), nl,
	write('|                               |'), nl,
	write('|_______________________________|'), nl,
	write('Choose an option:'), nl.