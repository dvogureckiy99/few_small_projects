#include<iostream>
#include<conio.h>
using namespace std;
void perestanovka(int* A, int n, int sum);
int main()
{
	setlocale(LC_ALL, "Russian");
	int* A;// ��������� �� ������
	int n;// ���������� ��������� �������
	int sum = 0;// ���������� ����� ��������� �������
	
	
	cout << "������� ������ ������� A : ";
	cin >> n;
	A = new int[n];
	
	for (int i = 0; i < n; i++)
	{
		cout << "A[" << i << "]=";
		cin >> A[i];//���� ��������� �������
		sum += A[i];//����� ���������
	}

	cout << "����� �����" << sum;
	perestanovka( A,  n, sum);

	for (int i = 0; i < n; i++)
	{
		cout << "\nA[" << i << "]=" << A[i];
	}
	
	_getch();
	return 0;
}
	
void perestanovka(int* A, int n,int sum)
{
	int temp;// ���������� ����������, ��� ������������ ��������� �������
	if (sum >= 200)
	{
		cout << "\n��� ������:\n";
		for (int i = n - 1; i > 0; i--)
		{
			for (int j = 0; j < i; j++)
			{
				if (A[j] > A[j + 1])
				{
					temp = A[j];
					A[j] = A[j + 1];
					A[j + 1] = temp;
				}
			}
		}
	}
	else
		cout << "\n������ ����� ��, ��� ��� ���� ����� ������ 200";
}
