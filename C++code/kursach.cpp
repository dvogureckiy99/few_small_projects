#include<iostream>
#include<conio.h>
#include <string>

using namespace std;


class InputController
{
private:
	string chek1;//��������� ����� ���������� ������
	string chek2;//��������� ����� ��������� ������
public:
	int kolvo;//��������� ���-�� �����
	int strl[25];//������ ������
	string razdelitel[1];//������� �����������
	string str[25];//������ �����



void get_str()//����� ����� ����� + ������� ��������� �����
{
	cout << "������� �����\n";
	for (int i = 0; i < 25; i++)
	{
		cout << "������� " << i + 1 << " ������ \n";
		getline(cin, str[i]);
		strl[i] = str[i].length();
		if (strl[i] > 100)
		{
			cout << "������� ����� 100 ��������, ����� ������ ��� ���." << endl;
			i--;
			continue;
		}


	}
}
	
void get_razdelitel()//����� ����� ������������
{
	int razdelitel_l;// ���-�� ������������
	cout << "������� �����������:" << endl;
	char a;
	int probel = 0;// ������ �� ����������
	for (int i = 0; i < 5; i++)
	{

		cout << i + 1 << ")=";
		cin >> razdelitel[0][i];
		
		cout << "\n���������� ���� ������������ ? (1 � ��, ��� � ����� ������) ";
		cin >> a;
		cout << endl;
		if (a == '1')
		{
			break;
		}
	}
	razdelitel_l = razdelitel[0].length();
	cout << "���������� ������������ " << razdelitel_l << endl;
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


		
	
		
	
	

	
	
		
	
	
				
	