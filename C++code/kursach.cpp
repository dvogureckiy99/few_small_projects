#include<iostream>
#include<conio.h>
#include <string>

using namespace std;


class InputController
{
private:
	string chek1;//Последнее слово предыдущей строки
	string chek2;//Последнее слово настоящей строки
public:
	int kolvo;//финальное кол-во строк
	int strl[25];//длинна строки
	string razdelitel[1];//символы разделители
	string str[25];//массив строк



void get_str()//метод ввода строк + условие остановки ввода
{
	cout << "Введите текст\n";
	for (int i = 0; i < 25; i++)
	{
		cout << "Введите " << i + 1 << " строку \n";
		getline(cin, str[i]);
		strl[i] = str[i].length();
		if (strl[i] > 100)
		{
			cout << "Введено более 100 символов, введи строку еще раз." << endl;
			i--;
			continue;
		}


	}
}
	
void get_razdelitel()//метод ввода разделителей
{
	int razdelitel_l;// кол-во разделителей
	cout << "Введите разделитель:" << endl;
	char a;
	int probel = 0;// пробел на клавиатуре
	for (int i = 0; i < 5; i++)
	{

		cout << i + 1 << ")=";
		cin >> razdelitel[0][i];
		
		cout << "\nпрекратить ввод разделителей ? (1 — да, нет — любой символ) ";
		cin >> a;
		cout << endl;
		if (a == '1')
		{
			break;
		}
	}
	razdelitel_l = razdelitel[0].length();
	cout << "Количество разделителей " << razdelitel_l << endl;
}

	
};

class TextProcessor
{
	
};
		
		


int main()
{
	setlocale(LC_ALL, "Russian");
	InputController *vvod = new InputController;
	/*vvod->get_str();
	delete vvod;*/
	vvod->get_razdelitel();
	
	
	_getch();
	return 0;
}


		
	
		
	
	

	
	
		
	
	
				
	