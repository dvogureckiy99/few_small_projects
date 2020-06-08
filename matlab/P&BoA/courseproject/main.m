clc
clear all
data=menu('Выберите способ ввода данных','Ввод с клавиатуры','Считывание из файла','Завершить программу');
switch data
    case 1
        [a,b,c,d,eps,xmin,xmax]=fromkeyboard();
    case 2
        [a,b,c,d,eps,xmin,xmax]=fromfile();
    otherwise
        error('Вы не выбрали способ ввода данных');
end
method=menu('Выберите метод поиска корня','Метод половинного деления','Метод ложного положения','Завершить программу');
switch method
    case 1
        [ansx,ansy,resx,resy] = Bisection(a,b,c,d,eps,xmin,xmax);
        method='половинного деления';
    case 2
        [ansx,ansy,resx,resy] = FalsePos(a,b,c,d,eps,xmin,xmax);
        method='ложного положения';
    otherwise
        error('Вы не выбрали метод поиска корня');
end
output=menu('Выберите способ вывода полученных данных','Вывод на экран','Вывод в файл','Вывод в файл и на экран','Завершить программу');
switch output
    case 1
        outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    case 2
        outInFile(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    case 3
        outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
        outInFile(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    otherwise
        error('Вы не выбрали способ вывода данных');
end
x=xmin:xmax;
y=a*x.^3+b*x.^2+c*x+d;
plot(x,y,'b-')
title('График функции y(x)')
grid
xlabel('Значения x')
ylabel('Значения y')
hold on
plot(ansx,ansy,'r*')
hold off