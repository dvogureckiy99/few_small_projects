������ �5

������� �� ������������ ������: 
������� ����� "�������", �������������� ����� �������� ������� ������ �� ���������.

����� ������ ��������� ��������� ��������:
- ���������� ������ �������;
- ����� �������

����� ������ ��������� ��������� ������:
- ������� � ������� ��� ���������;
- ������ ��� ����� �������;
- �����, ������������ ����� ������� (��������� ��������� � ��������������� ��������);
- �����, ������������ ����������� ���������� ������������ �� ������� ������� � 
���� ������ �������� (� �������� ��������� ����� ��������� ��� ������� ������ "�������").

� ������� ������� ��������� ������� ��� ������������ �������, ��������� 
� ���������� ���������� �� ������, ���������� � ������� �� ����� ����� ��� 
��������, ����������, ����� �� ��� ������� ���� ��������� ������ ������������.


#include<iostream>
#include<conio.h>
using namespace std;

class line_segment
{
	private:
		int x1; //���������� ������ ������� �� ��� ��
		int x2;//���������� ����� ������� �� ��� ��
		int y1;//���������� ������ ������� �� ��� �Y
		int y2;//���������� ����� ������� �� ��� �Y
		float length; // ������ �������
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
				cout << "\n��� ������ ����� ���������� �����������.";
			else
				cout << "\n��� ������ ����������� ���������� �� �����.";
		}
};

int main(void)
{
	setlocale(LC_ALL, "Russian");
	int userx1;//���������� ������ ������� �� ��� ��
	int userx2;//���������� ����� ������� �� ��� ��
	int usery1;//���������� ������ ������� �� ��� �Y
	int usery2;//���������� ����� ������� �� ��� �Y

	line_segment *ls;
	ls = new line_segment[3];

	//���� ��������� ������� � ������ �� � �������� ������
	for (int i = 0; i < 3; i++)
	{
		cout << "������� ���������� ������� �" << i+1 << " :\n";
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
		cout << "\n������ ������� �" << i+1 << ": " << ls[i].get_length() << "";
	}
	
	ls[0].triangle(ls[1], ls[2]);
	
	_getch();
	return 0;
}


