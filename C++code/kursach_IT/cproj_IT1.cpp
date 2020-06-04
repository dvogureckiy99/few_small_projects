#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include<fstream>
#include <string>

#include <conio.h>//для функции _getch()

using namespace std;

class InputController
{
private:
	char* razd;										// указатель на разделители
	string* stroka; 								// указатель на буфер для всего текста
	string	str;									// хранит вспомогательную строку
	char* world;
	int N_0;
	int N;											// число строк в тексте	
	int sum;

public:
	InputController(char*, string*, char*);			// инициализирует указатели
	bool yslovie_0(string str, int i);				// проверка на выход диапазона
	void output(void);
	void SetWorld(void);							// ввод слова пользователя
	void SetRazd(void);								// ввод разделителей
	bool yslovie1(string);							// условие прекращения ввода
	void SetText(void);								// ввод текста
	int  GetN(void);								// возвращает число строк в записанном тексте
};

class TextProcessor
{
private:
	char* razd;										// указатель на разделители
	string* stroka; 								// указатель на буфер для всего текста
	int N;											// число строк в тексте	

public:
	TextProcessor(char*, string*, int);				//инициализирует указатели
	bool yslovie2(int N);							// уловие обработки
	void Obrabotka(int N);							// преобразует текст								
};

class OutputController
{
private:
	string* stroka; 								// промежуточный буфер для всего текста
	int N;											// хранит индекс последней введённой строки
public:
	OutputController(string*, int);					// инициализирует указатели
	void vivodTexta(int N);							// выводит текст в соответствии с условием						
};



InputController::InputController(char* name1, string* name2, char* name3)			//описываем переменные
{
	razd = name1;
	stroka = name2;
	world = name3;
}

bool InputController::yslovie_0(string str, int i)									//проверяем на выход за границы
{
	if (str.size() > i)
		return true;
}

void InputController::output(void)													//вывод, если за пределами
{
	cout << "----------------------------------------------------------------------" << endl;
	cout << "Error!\n The entered word consists of more than 5 letters!\n Only the first 10 simoles will be used!" << endl;
	cout << "----------------------------------------------------------------------" << endl;
}

void	InputController::SetWorld(void)														//функция ввода
{																							//
	getline(cin, str);																		//вводим данные
	int k = 0;																				//
	if (yslovie_0(str, 10) == true)															//проверяем на условие выхода за пределы
		output();																			//
	for (int i = 0; i < str.size() && i < 10; i++) { world[i] = str[i]; N_0++; k = i; }		//перенос в буфер
	world[k + 1] = NULL;																		//вставляем символ конца строки 
	cout << " введенное слово: ";															//
	for (int i = 0; i<10 && i<str.size(); i++) { cout << world[i]; }						//выводим на экран
	cout << endl;																			//
}

void	InputController::SetRazd(void)														//ввод разделителей
{																							//
	getline(cin, str);																		//вводим данные
	int k = 0;																				//
	if (yslovie_0(str, 5) == true)	output();												//проверяем на условие выхода за пределы 
	for (int i = 0; i < str.size() && i < 5; i++) { razd[i] = str[i]; k = i; }				//перенос в буфер
	razd[k + 1] = NULL;																		//ставляем символ конца строки 
	cout << " Получены разделители: ";														//
	for (int i = 0; i<5 && i<str.size(); i++) { cout << razd[i]; }							//выводим на экран
	cout << endl;																			//
}																							//
																							//

bool InputController::yslovie1(string str)													//считаем кол-во слов в одной строке, если 7, то останавливаем ввод
{																							//
	int k = 0;																				//
																							//
	int sum_0 = 0;																			//
	for (int j = 0; (j < 100) && (j < str.size()); j++, k++)								//идем по массиву символов строки
	{																						//
		sum_0 = 0;																			//обулим переменные, чтобы работали правильно
		k = 0;																				//
		if (str[j] == world[k])																//если нашли первый одинаковый символ
		{																					//
			j++; k++;																		//перешли к след символу
																							//
			sum_0 += 1;																		//
			while (strchr(razd, str[j]) == NULL || str[j] == '\0')							//проверка, если символ не разделитель 
			{																				//
				if (str[j] != '\0')															//если не 
					if (str[j] == str[j] && strchr(razd, str[j]) == NULL)					//если 2 символа равны и этот символ не равен разделителю
					{																		//
						sum_0 += 1;															//
						k++;																//
					}																		//
					else break;																//
					j++;																	//
					if (j >= str.size())													//
						break;																//
			}																				//
		}																					//
		else																				//
		{																					//
			while (strchr(razd, str[j]) == NULL && strchr(razd, '\0') == NULL)				//цикл будет выполняться, пока символ будет не равен разделителю и не конец строки
				j++;																		//
		}																					//
		if (sum_0 == N_0)																	//
			sum += 1;																		//
	}																						//
	if (sum >= 7)																			//
		return true;																		//
}																							//

void	InputController::SetText(void)														//ввод текста
{
	int l = 0;																				//
	N = 0; 																					//
	sum = 0;																				//
	for (int i = 0; i<25; i++)																//идем по массиву строк
	{																						//
		N++;																				//
		cout << " строка " << i + 1 << " : ";													//
		getline(cin, str);																	//вводим строку
		for (int j = 0; (j < 101) && (j < str.size() + 1); j++)								////перенос в буфер не более 100 символов
		{																					//
			stroka[i] += str[j];															//
			l = j;																			//
		}																					//
		stroka[i] += '\0';																	//ставим в конце символ конца строки
																							//
		if (true == yslovie1(str))															//проверяем, почему завершилась остановка
		{																					//
			cout << "Ввод завершён по условию" << endl;										//
			break;																			//
		}																					//
	}																						//
	if (yslovie1(str) == false)	cout << "Ввод завершён из-зи превышения числа строк" << endl;//
}																							//

int		InputController::GetN(void)															//длина строки
{
	return N;
}

TextProcessor::TextProcessor(char* name1, string*	name2, int n)							//описываем перемеенные, присваиваем им данные
{
	razd = name1;
	stroka = name2;
	N = n;

}

bool TextProcessor::yslovie2(int N)															//если кол-во строк кратно 2, 3 или 5, то все хорошо
{
	if (N % 2 == 0 || N % 3 == 0 || N % 5 == 0)
		return true;
}

void TextProcessor::Obrabotka(int N)																	//
{																										//
																										//
	char * pos3 = new char;																				//это указатель, он нам нужен для этого: kol = strcspn(pch + 1, pos3); об strcspn почитайте в интернете
	*pos3 = '\0';																						//
	int kol;																							//
																										//
	if (yslovie2(N) == true)																			//если условие 2 "хорошо", то выполняем
	{																									//
		kol = 0;																						//
		for (int i = 1; i < N + 1; i++)																	//идм по строкам
		{																								//
			int n = stroka[i - 1].size();																	//кол-во элементов в строке
			kol = 0;																					//
			char *str = new char[n + 1];																	//создаем новый массив для работы с ним, чтобы начальный не изменился 
			for (int l = 0; l < n + 1; l++) { str[l] = stroka[i - 1][l]; }						//записываем в него данные из строки
			for (int l = 0; l < n + 1; l++) { stroka[i - 1][l] = NULL; }									//а в массиве строк, стираем данные это строки (чтобы потом не было никаких лишних элементов
																											//
			if (i % 2 == 0 || i % 3 == 0)																//если строка кратна 2 или 3
			{																							//
				char * pch = strpbrk(str, razd);														//нашли первый разделитель
																										//
																										//
				if (i % 3 == 0 && pch != NULL && i % 2 != 0)											//если строка кратна 3, указатель указывает не на конец строки, строка кратна 3 (это место, 
				{																						//
					pch = strpbrk(pch + 1, razd);														//нашли второй разделитель
																										//
				}																						//
																										//в результате на данный момент получаетс так, если строка кратна 2, то указатель указывает на начало 2 слова, если строка кратна 3, то 3
				if (pch == NULL)																			//
					pch = strchr(str, '\0');															//
																										//
																										//
				kol = strcspn(pch + 1, razd);															//найти кол-во символов в слове		
																										//
				if (kol == NULL)																		//
					kol = strcspn(pch + 1, pos3);														//
																										//
				strcpy(pch + 1, pch + 1 + kol);															//сместили на такое кол-во символов	
																										//
				n = n - kol - 1;																			//
																											//удаление всех разделителей справа														//
				pch = strpbrk(pch + 1, razd);															//перемещаем указатель вправо на один
				while (pch != '\0' && pch != NULL)														//пока указатель не будет указывать на конец строки
				{																						//
					strcpy(pch, pch + 1);																//смещаем на один вправо (фото 2)
					pch = strpbrk(pch, razd);															//ищем место разделителя
					if (pch != '\0' && pch == NULL)														//если не конец, перемещаемся вправо
						pch = strpbrk(pch + 1, razd);														//
					n = n - 1;																			//если удаляем разделитель, значит надо уменьшить длину строки на 1
				}																						//
			}																							//
			for (int l = 0; l < n; l++) { stroka[i - 1][l] = str[l]; }							//
																								//
		}																							//
	}																									//
	delete pos3;																						//очищаем память разделителя, чтобы не было утечи информации.  Так как указатель указывает на определенную область памяти
																										//
}																										//

OutputController::OutputController(string* name1, int n)
{
	stroka = name1;
	N = n;
}

void OutputController::vivodTexta(int N)
{
	for (int i = 0; i < N; i++)
	{
		cout << stroka[i] << endl;
	}
}
class Menu
{

public:
	char choose;


	void menu(InputController VT, TextProcessor OT, OutputController ZT, int N)
	{
		while (1)
		{
			cout << "выбери действие :" << endl;
			cout << "1-условие" << endl;
			cout << "2-Ввод разделителей и слова" << endl;
			cout << "3-Ввод текста" << endl;
			cout << "4-Вывод текста" << endl;
			cout << "0-выход" << endl;


			choose = _getch();


			switch (choose)
			{
			case '1':
				system("cls");
				cout << "Остановить ввод текста:\nесли во введённом тексте встречается заданное пользователем слово не менее семи раз " << endl;
				cout << "Обработка текста :\nЕсли в тексте количество строк будет кратно двум, трём или пяти, удалить из каждой строки, номер которой кратен двум, второе слово и разделители справа; из каждой строки, номер которой кратен трём, третье слово и разделители справа. Если номер строки кратен и двум, и трём одновременно, применять правила для кратности двум" << endl;
				system("pause");
				system("cls");
				break;
			case '2':
				system("cls");
				cout << "2-Ввод разделителей:" << endl;
				VT.SetRazd();													//VT-переменная класса, чтобы могли обратиться к классу. SetRazd - функция класса. Как бы указываем программе выполнить в таком-то классе такую-то функцию
				cout << "1-Ввод слова:" << endl;
				VT.SetWorld();

				system("pause");
				system("cls");
				break;
			case '3':
				system("cls");
				cout << "3-Ввод текста:" << endl;
				VT.SetText();
				system("pause");
				system("cls");
				break;
			case '4':
				system("cls");
				N = VT.GetN();									// число строк нужно в других классах	
				cout << "текст до обработки:" << endl;
				ZT.vivodTexta(N);
				cout << endl;

				cout << " Текст переделан в соответствии с условиями" << endl;


				OT.Obrabotka(N);

				cout << "----------------------------------------------------------------------" << endl;
				cout << "Переделанный текст: " << endl;
				cout << "----------------------------------------------------------------------" << endl;

				ZT.vivodTexta(N);
				system("pause");
				system("cls");
				break;
			default:
				system("cls");
				break;
			}
			if (choose == '0')
				break;
		}
	}

};

int main()
{
	setlocale(LC_ALL, "Russian");

	char* razd = new char[6];
	string* stroka = new string[26];
	char* world = new char[11];
	char* str = new char[101];
	int N = 0;
	int sum;
	InputController   VT(razd, stroka, world);		//описываем переменные  VT-ввод текста
	TextProcessor OT(razd, stroka, N);				//описываем переменные  OT-обработка
	OutputController	ZT(stroka, N);				//описываем переменные  ZT-вывод
	Menu inter;
	inter.menu(VT, OT, ZT, N);
	system("pause");
	return 0;
}


