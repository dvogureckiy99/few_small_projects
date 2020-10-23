# Лабораторная работа:

Цель работы: исследование скользящих режимов в системах с переменной
структурой методом фазовой плоскости.
---

1. [Отчет](Tex/report.pdf)
	
1. Код отчета на языке Latex разделен на несколько файлов:

	- [Главный файл](Tex/report.tex)
	- Общие файли:
		+ [Настройка параметров для компиляции и 
			подключение модулей](Tex/common/setup.tex).
		+ [Оформление титульной страницы](Tex/common/title_page.tex).
	- [Наполнение отчета](Tex/components/SYSTEMS_WITH_VARIABLE_STRUCTURE/):
		
1. Скрипты на языке MATLAB 
	
	Для эмуляции нажатия кнопки "F5" после окончания всех операций в MATLAB, которая запустит компиляцию кода на языке Latex используется сторонняя библиотека 
	"INPUTEMU   Java-Based Mouse/Keyboard Emulator"
	
	и используется сторонняя библиотека 
	REPLACEINFILE replaces characters in ASCII file using PERL
	
	+ [Главный скрипт на языке MATLAB, создающий код на языке LaTex](matlab/make_report.m)

	+ Для реализации вспомогательных функций созданы:
		- [вставка необходимых рисунков](matlab/past_figure.m)
		- Быстрое написание LaTex команд:
			+ [just make a text string into latex document named by fid](matlab/scripts/Latex_command/latex_text.m)
			+ [Past image in tex document](matlab/scripts/Latex_command/tex_past_figure.m)
		