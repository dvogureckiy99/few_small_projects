#include<iostream>
#include<conio.h>
using namespace std;
void perestanovka(int* A, int n, int sum);
int main()
{
	setlocale(LC_ALL, "Russian");
	int* A;// Указатель на массив
	int n;// количество элементов массива
	int sum = 0;// объявление суммы элементов массива
	
	
	cout << "Введите размер массива A : ";
	cin >> n;
	A = new int[n];
	
	for (int i = 0; i < n; i++)
	{
		cout << "A[" << i << "]=";
		cin >> A[i];//ввод элементов массива
		sum += A[i];//сумма элементов
	}

	cout << "Сумма равна" << sum;
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
	int temp;// объявление переменной, для перестановки элементов массива
	if (sum >= 200)
	{
		cout << "\nНаш массив:\n";
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
		cout << "\nМассив такой же, так как наша сумма меньше 200";
}
