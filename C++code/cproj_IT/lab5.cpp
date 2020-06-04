Работа №5

Задание на лабораторную работу: 
Описать класс "Отрезок", представляющий собой описание отрезка прямой на плоскости.

Класс должен содержать следующие свойства:
- координаты концов отрезка;
- длина отрезка

Класс должен содержать следующие методы:
- геттеры и сеттеры для координат;
- геттер для длины отрезка;
- метод, определяющий длину отрезка (результат заносится в соответствующее свойство);
- метод, определяющий возможность построения треугольника из данного отрезка и 
двух других отрезков (в качестве параметра метод принимает два объекта класса "Отрезок").

В главной функции программы создать три произвольных отрезка, заполнить 
с клавиатуры координаты их концов, определить и вывести на экран длины трёх 
отрезков, определить, могут ли эти отрезки быть сторонами одного треугольника.


#include<iostream>
#include<conio.h>
using namespace std;

class line_segment
{
	private:
		int x1; //Координата начала отрезка по оси ОХ
		int x2;//Координата конца отрезка по оси ОХ
		int y1;//Координата начала отрезка по оси ОY
		int y2;//Координата конца отрезка по оси ОY
		float length; // Длинна отрезка
	public:
		void set_length()
		{
			length = sqrt( (float)((x2 - x1)*(x2-x1) + (y2 - y1)*(y2-y1)));
		}
	
		float get_length()
		{
			return length;
		}
	
		void set_coordinates(int new_x1,int new_x2,int new_y1,int new_y2)
		{
			x1 = new_x1;
			x2 = new_x2;
			y1 = new_y1;
			y2 = new_y2;
		}
	
		int get_x1()
		{
			return x1;
		}
		int get_x2()
		{
			return  x2;
		}
		int get_y1()
		{
			return  y1;
		}
		int get_y2()
		{
			return  y2;
		}

		void triangle(line_segment new_ls1, line_segment new_ls2)
		{
			if ((   length > abs( new_ls1.get_length() - new_ls2.get_length() )  ) && (length < new_ls1.get_length() + new_ls2.get_length()))
				cout << "\nЭти прямые могут образовать треугольник.";
			else
				cout << "\nЭти прямые треугольник образовать не могут.";
		}
};

int main(void)
{
	setlocale(LC_ALL, "Russian");
	int userx1;//Координата начала отрезка по оси ОХ
	int userx2;//Координата конца отрезка по оси ОХ
	int usery1;//Координата начала отрезка по оси ОY
	int usery2;//Координата конца отрезка по оси ОY

	line_segment *ls;
	ls = new line_segment[3];

	//ввод координат отрезка и запись их в свойства класса
	for (int i = 0; i < 3; i++)
	{
		cout << "Введите координаты отрезка №" << i+1 << " :\n";
		cout << "(x1)=";
		cin >> userx1;
		cout << "(y1)=";
		cin >> usery1;
		cout << "\n(x2)=";
		cin >> userx2;
		cout << "(y2)=";
		cin >> usery2;
		cout << "\n";
	    ls[i].set_coordinates(userx1, userx2, usery1, usery2);
	}
	
	for (int i = 0; i < 3; i++)
	{
		ls[i].set_length();
		cout << "\nДлинна отрезка №" << i+1 << ": " << ls[i].get_length() << "";
	}
	
	ls[0].triangle(ls[1], ls[2]);
	
	_getch();
	return 0;
}


