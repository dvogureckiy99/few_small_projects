#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include<fstream>
#include <string>

#include <conio.h>//��� ������� _getch()

using namespace std;

class InputController
{
private:
	char* razd;										// ��������� �� �����������
	string* stroka; 								// ��������� �� ����� ��� ����� ������
	string	str;									// ������ ��������������� ������
	char* world;
	int N_0;
	int N;											// ����� ����� � ������	
	int sum;

public:
	InputController(char*, string*, char*);			// �������������� ���������
	bool yslovie_0(string str, int i);				// �������� �� ����� ���������
	void output(void);
	void SetWorld(void);							// ���� ����� ������������
	void SetRazd(void);								// ���� ������������
	bool yslovie1(string);							// ������� ����������� �����
	void SetText(void);								// ���� ������
	int  GetN(void);								// ���������� ����� ����� � ���������� ������
};

class TextProcessor
{
private:
	char* razd;										// ��������� �� �����������
	string* stroka; 								// ��������� �� ����� ��� ����� ������
	int N;											// ����� ����� � ������	

public:
	TextProcessor(char*, string*, int);				//�������������� ���������
	bool yslovie2(int N);							// ������ ���������
	void Obrabotka(int N);							// ����������� �����								
};

class OutputController
{
private:
	string* stroka; 								// ������������� ����� ��� ����� ������
	int N;											// ������ ������ ��������� �������� ������
public:
	OutputController(string*, int);					// �������������� ���������
	void vivodTexta(int N);							// ������� ����� � ������������ � ��������						
};



InputController::InputController(char* name1, string* name2, char* name3)			//��������� ����������
{
	razd = name1;
	stroka = name2;
	world = name3;
}

bool InputController::yslovie_0(string str, int i)									//��������� �� ����� �� �������
{
	if (str.size() > i)
		return true;
}

void InputController::output(void)													//�����, ���� �� ���������
{
	cout << "----------------------------------------------------------------------" << endl;
	cout << "Error!\n The entered word consists of more than 5 letters!\n Only the first 10 simoles will be used!" << endl;
	cout << "----------------------------------------------------------------------" << endl;
}

void	InputController::SetWorld(void)														//������� �����
{																							//
	getline(cin, str);																		//������ ������
	int k = 0;																				//
	if (yslovie_0(str, 10) == true)															//��������� �� ������� ������ �� �������
		output();																			//
	for (int i = 0; i < str.size() && i < 10; i++) { world[i] = str[i]; N_0++; k = i; }		//������� � �����
	world[k + 1] = NULL;																		//��������� ������ ����� ������ 
	cout << " ��������� �����: ";															//
	for (int i = 0; i<10 && i<str.size(); i++) { cout << world[i]; }						//������� �� �����
	cout << endl;																			//
}

void	InputController::SetRazd(void)														//���� ������������
{																							//
	getline(cin, str);																		//������ ������
	int k = 0;																				//
	if (yslovie_0(str, 5) == true)	output();												//��������� �� ������� ������ �� ������� 
	for (int i = 0; i < str.size() && i < 5; i++) { razd[i] = str[i]; k = i; }				//������� � �����
	razd[k + 1] = NULL;																		//�������� ������ ����� ������ 
	cout << " �������� �����������: ";														//
	for (int i = 0; i<5 && i<str.size(); i++) { cout << razd[i]; }							//������� �� �����
	cout << endl;																			//
}																							//
																							//

bool InputController::yslovie1(string str)													//������� ���-�� ���� � ����� ������, ���� 7, �� ������������� ����
{																							//
	int k = 0;																				//
																							//
	int sum_0 = 0;																			//
	for (int j = 0; (j < 100) && (j < str.size()); j++, k++)								//���� �� ������� �������� ������
	{																						//
		sum_0 = 0;																			//������ ����������, ����� �������� ���������
		k = 0;																				//
		if (str[j] == world[k])																//���� ����� ������ ���������� ������
		{																					//
			j++; k++;																		//������� � ���� �������
																							//
			sum_0 += 1;																		//
			while (strchr(razd, str[j]) == NULL || str[j] == '\0')							//��������, ���� ������ �� ����������� 
			{																				//
				if (str[j] != '\0')															//���� �� 
					if (str[j] == str[j] && strchr(razd, str[j]) == NULL)					//���� 2 ������� ����� � ���� ������ �� ����� �����������
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
			while (strchr(razd, str[j]) == NULL && strchr(razd, '\0') == NULL)				//���� ����� �����������, ���� ������ ����� �� ����� ����������� � �� ����� ������
				j++;																		//
		}																					//
		if (sum_0 == N_0)																	//
			sum += 1;																		//
	}																						//
	if (sum >= 7)																			//
		return true;																		//
}																							//

void	InputController::SetText(void)														//���� ������
{
	int l = 0;																				//
	N = 0; 																					//
	sum = 0;																				//
	for (int i = 0; i<25; i++)																//���� �� ������� �����
	{																						//
		N++;																				//
		cout << " ������ " << i + 1 << " : ";													//
		getline(cin, str);																	//������ ������
		for (int j = 0; (j < 101) && (j < str.size() + 1); j++)								////������� � ����� �� ����� 100 ��������
		{																					//
			stroka[i] += str[j];															//
			l = j;																			//
		}																					//
		stroka[i] += '\0';																	//������ � ����� ������ ����� ������
																							//
		if (true == yslovie1(str))															//���������, ������ ����������� ���������
		{																					//
			cout << "���� �������� �� �������" << endl;										//
			break;																			//
		}																					//
	}																						//
	if (yslovie1(str) == false)	cout << "���� �������� ��-�� ���������� ����� �����" << endl;//
}																							//

int		InputController::GetN(void)															//����� ������
{
	return N;
}

TextProcessor::TextProcessor(char* name1, string*	name2, int n)							//��������� �����������, ����������� �� ������
{
	razd = name1;
	stroka = name2;
	N = n;

}

bool TextProcessor::yslovie2(int N)															//���� ���-�� ����� ������ 2, 3 ��� 5, �� ��� ������
{
	if (N % 2 == 0 || N % 3 == 0 || N % 5 == 0)
		return true;
}

void TextProcessor::Obrabotka(int N)																	//
{																										//
																										//
	char * pos3 = new char;																				//��� ���������, �� ��� ����� ��� �����: kol = strcspn(pch + 1, pos3); �� strcspn ��������� � ���������
	*pos3 = '\0';																						//
	int kol;																							//
																										//
	if (yslovie2(N) == true)																			//���� ������� 2 "������", �� ���������
	{																									//
		kol = 0;																						//
		for (int i = 1; i < N + 1; i++)																	//��� �� �������
		{																								//
			int n = stroka[i - 1].size();																	//���-�� ��������� � ������
			kol = 0;																					//
			char *str = new char[n + 1];																	//������� ����� ������ ��� ������ � ���, ����� ��������� �� ��������� 
			for (int l = 0; l < n + 1; l++) { str[l] = stroka[i - 1][l]; }						//���������� � ���� ������ �� ������
			for (int l = 0; l < n + 1; l++) { stroka[i - 1][l] = NULL; }									//� � ������� �����, ������� ������ ��� ������ (����� ����� �� ���� ������� ������ ���������
																											//
			if (i % 2 == 0 || i % 3 == 0)																//���� ������ ������ 2 ��� 3
			{																							//
				char * pch = strpbrk(str, razd);														//����� ������ �����������
																										//
																										//
				if (i % 3 == 0 && pch != NULL && i % 2 != 0)											//���� ������ ������ 3, ��������� ��������� �� �� ����� ������, ������ ������ 3 (��� �����, 
				{																						//
					pch = strpbrk(pch + 1, razd);														//����� ������ �����������
																										//
				}																						//
																										//� ���������� �� ������ ������ ��������� ���, ���� ������ ������ 2, �� ��������� ��������� �� ������ 2 �����, ���� ������ ������ 3, �� 3
				if (pch == NULL)																			//
					pch = strchr(str, '\0');															//
																										//
																										//
				kol = strcspn(pch + 1, razd);															//����� ���-�� �������� � �����		
																										//
				if (kol == NULL)																		//
					kol = strcspn(pch + 1, pos3);														//
																										//
				strcpy(pch + 1, pch + 1 + kol);															//�������� �� ����� ���-�� ��������	
																										//
				n = n - kol - 1;																			//
																											//�������� ���� ������������ ������														//
				pch = strpbrk(pch + 1, razd);															//���������� ��������� ������ �� ����
				while (pch != '\0' && pch != NULL)														//���� ��������� �� ����� ��������� �� ����� ������
				{																						//
					strcpy(pch, pch + 1);																//������� �� ���� ������ (���� 2)
					pch = strpbrk(pch, razd);															//���� ����� �����������
					if (pch != '\0' && pch == NULL)														//���� �� �����, ������������ ������
						pch = strpbrk(pch + 1, razd);														//
					n = n - 1;																			//���� ������� �����������, ������ ���� ��������� ����� ������ �� 1
				}																						//
			}																							//
			for (int l = 0; l < n; l++) { stroka[i - 1][l] = str[l]; }							//
																								//
		}																							//
	}																									//
	delete pos3;																						//������� ������ �����������, ����� �� ���� ����� ����������.  ��� ��� ��������� ��������� �� ������������ ������� ������
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
			cout << "������ �������� :" << endl;
			cout << "1-�������" << endl;
			cout << "2-���� ������������ � �����" << endl;
			cout << "3-���� ������" << endl;
			cout << "4-����� ������" << endl;
			cout << "0-�����" << endl;


			choose = _getch();


			switch (choose)
			{
			case '1':
				system("cls");
				cout << "���������� ���� ������:\n���� �� �������� ������ ����������� �������� ������������� ����� �� ����� ���� ��� " << endl;
				cout << "��������� ������ :\n���� � ������ ���������� ����� ����� ������ ����, ��� ��� ����, ������� �� ������ ������, ����� ������� ������ ����, ������ ����� � ����������� ������; �� ������ ������, ����� ������� ������ ���, ������ ����� � ����������� ������. ���� ����� ������ ������ � ����, � ��� ������������, ��������� ������� ��� ��������� ����" << endl;
				system("pause");
				system("cls");
				break;
			case '2':
				system("cls");
				cout << "2-���� ������������:" << endl;
				VT.SetRazd();													//VT-���������� ������, ����� ����� ���������� � ������. SetRazd - ������� ������. ��� �� ��������� ��������� ��������� � �����-�� ������ �����-�� �������
				cout << "1-���� �����:" << endl;
				VT.SetWorld();

				system("pause");
				system("cls");
				break;
			case '3':
				system("cls");
				cout << "3-���� ������:" << endl;
				VT.SetText();
				system("pause");
				system("cls");
				break;
			case '4':
				system("cls");
				N = VT.GetN();									// ����� ����� ����� � ������ �������	
				cout << "����� �� ���������:" << endl;
				ZT.vivodTexta(N);
				cout << endl;

				cout << " ����� ��������� � ������������ � ���������" << endl;


				OT.Obrabotka(N);

				cout << "----------------------------------------------------------------------" << endl;
				cout << "������������ �����: " << endl;
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
	InputController   VT(razd, stroka, world);		//��������� ����������  VT-���� ������
	TextProcessor OT(razd, stroka, N);				//��������� ����������  OT-���������
	OutputController	ZT(stroka, N);				//��������� ����������  ZT-�����
	Menu inter;
	inter.menu(VT, OT, ZT, N);
	system("pause");
	return 0;
}


