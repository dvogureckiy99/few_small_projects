clc
clear all
data=menu('�������� ������ ����� ������','���� � ����������','���������� �� �����','��������� ���������');
switch data
    case 1
        [a,b,c,d,eps,xmin,xmax]=fromkeyboard();
    case 2
        [a,b,c,d,eps,xmin,xmax]=fromfile();
    otherwise
        error('�� �� ������� ������ ����� ������');
end
method=menu('�������� ����� ������ �����','����� ����������� �������','����� ������� ���������','��������� ���������');
switch method
    case 1
        [ansx,ansy,resx,resy] = Bisection(a,b,c,d,eps,xmin,xmax);
        method='����������� �������';
    case 2
        [ansx,ansy,resx,resy] = FalsePos(a,b,c,d,eps,xmin,xmax);
        method='������� ���������';
    otherwise
        error('�� �� ������� ����� ������ �����');
end
output=menu('�������� ������ ������ ���������� ������','����� �� �����','����� � ����','����� � ���� � �� �����','��������� ���������');
switch output
    case 1
        outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    case 2
        outInFile(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    case 3
        outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
        outInFile(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method);
    otherwise
        error('�� �� ������� ������ ������ ������');
end
x=xmin:xmax;
y=a*x.^3+b*x.^2+c*x+d;
plot(x,y,'b-')
title('������ ������� y(x)')
grid
xlabel('�������� x')
ylabel('�������� y')
hold on
plot(ansx,ansy,'r*')
hold off