clear, clc
 
x = 5 - 10*rand(1,500000);
y = 5 - 10*rand(1,500000);
 
L1 = 0.9*x-y-z-a-b-c >= 0;
L2 = 1.15*y-x-z-a-b-c >=0;
L3 = 
 
% ���������� ������ �������
L = L1 & L2; 
a = x(L);
b = y(L);
% ���������, �� ��� ������������� �������
plot(a,b,'.r')
axis equal