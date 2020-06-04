
#include "stdafx.h"
#include <iostream>
#include <cstring>
#include <stdio.h>
#include <cctype>
#include <conio.h> //библиотека содержит функции для работы с экраном

#define OUTPUT_STRING "ni e" //Выводимая строка (обязательно прописными буквами !!!)

using namespace std;

int main() {
	int i;
	char j;
	char output_string[] = OUTPUT_STRING;
	cout << output_string << endl; 
	cout << "len output_string =" << strlen(output_string) << endl;
	
	char coded_string[200] = "" ;
	//в переменной массива последний символ "\0" !!!  
	char mrz[]="" ; //хранит кодировку символа морза 
	for (i = 0; i < strlen(output_string); i++)
	{

		output_string[i] = tolower(output_string[i]);
		switch (output_string[i])
		{
		case 'a': sprintf(mrz, "./-"); break;
		case 'b': sprintf(mrz, "-/././."); break;
		case 'w': sprintf(mrz, "./-/-"); break;
		case 'g': sprintf(mrz, "-/-/."); break;
		case 'd': sprintf(mrz, "-/./."); break;
		case 'e': sprintf(mrz, "."); break;
		case 'v': sprintf(mrz, "./././-"); break;
		case 'z': sprintf(mrz, "-/-/./."); break;
		case 'i': sprintf(mrz, "./."); break;
		case 'j': sprintf(mrz, "./-/-/-"); break;
		case 'k': sprintf(mrz, "-/./-"); break;
		case 'l': sprintf(mrz, "./-/./."); break;
		case 'm': sprintf(mrz, "-/-"); break;
		case 'n': sprintf(mrz, "-/."); break;
		case 'o': sprintf(mrz, "-/-/-"); break;
		case 'p': sprintf(mrz, "./-/-/."); break;
		case 'r': sprintf(mrz, "./-/."); break;
		case 's': sprintf(mrz, "././."); break;
		case 't': sprintf(mrz, "-"); break;
		case 'u': sprintf(mrz, "././-"); break;
		case 'f': sprintf(mrz, "././-/."); break;
		case 'h': sprintf(mrz, "./././."); break;
		case 'c': sprintf(mrz, "-/./-/."); break;
		case 'q': sprintf(mrz, "-/-/./-"); break;
		case 'y': sprintf(mrz, "-/./-/-"); break;
		case 'x': sprintf(mrz, "-/././-"); break;
		case '1': sprintf(mrz, "./-/-/-/-"); break;
		case '2': sprintf(mrz, "././-/-/-"); break;
		case '3': sprintf(mrz, "./././-/-"); break;
		case '4': sprintf(mrz, "././././-"); break;
		case '5': sprintf(mrz, "././././."); break;
		case '6': sprintf(mrz, "-/./././."); break;
		case '7': sprintf(mrz, "-/-/././."); break;
		case '8': sprintf(mrz, "-/-/-/./."); break;
		case '9': sprintf(mrz, "-/-/-/-/."); break;
		case '0': sprintf(mrz, "-/-/-/-/-"); break;
		case '.': sprintf(mrz, "./././././."); break;
		case ',': sprintf(mrz, "./-/./-/./-"); break;
		case ':': sprintf(mrz, "-/-/-/././."); break;
		case ';': sprintf(mrz, "-/./-/./-/."); break;
		case '(': sprintf(mrz, "-/./-/-/./-"); break;
		case ')': sprintf(mrz, "-/./-/-/./-"); break;
		case '"': sprintf(mrz, "./-/././-/."); break;
		case '-': sprintf(mrz, "-/././././-"); break;
		case '/': sprintf(mrz, "-/././-/."); break;
		case '?': sprintf(mrz, "././-/-/./."); break;
		case '!': sprintf(mrz, "-/-/././-/-"); break;
		case ' ': sprintf(mrz, " "); break; //пробел между словами
		case '@': sprintf(mrz, "./-/-/./-/."); break;
		default: sprintf(mrz, ""); break;

		}
		strcat(coded_string, mrz); //добавляем к конечной строке код символа в азбуке морза
		if ((output_string[i] != ' ' )&&(output_string[i+1] != ' '))
		{
			strcat(coded_string, ",");// указывает на паузу между  кодами символов
		}
		cout << "iter=" << i << endl;
	}
	cout << coded_string << endl;
	cout << "len coded_string =" << strlen(coded_string) << endl;
	cout << endl;
	

	_getch(); //функция ввода символа с клавиатуры. Используется для задержки
	return 0;
}
