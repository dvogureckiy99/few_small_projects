clc
clear
% данные
N=60; % число витков
r_v=0.14; % rв
r_j=0.3; % rя
c_e=290;
c_m=230;
J=0.1;
% номинальные значения
i_n=50;
w_n=100;
P_n=0.01;
M_sn=470;
U_sn=220;

global a11 a12 a13 a21 a22 a23 a31 a32 Q2
% коэффициенты 
a11=-(i_n*(r_v+r_j))/(N*P_n);
a12=-c_e*w_n/N;
a13=U_sn/(N*P_n);
a21=a11;
a22=a12;
a23=a13;
a31=c_m*P_n*i_n/(J*w_n);
a32=-M_sn/(J*w_n);
X=[1.5396; 2.6546; 0.3619];%номинальном воздействии

%начальные значения
x0=[0,0,0];
Uc=0;
Mc=0.3;

% производная от полинома p(Ф)
Q2=[-0.381 0 2.292 0 0.3415];
Q3=polyder(Q2);

A=[a12*X(3), a11, a12*X(1); 
    a22*X(3)*polyval(Q3, X(1)), a21*polyval(Q2, X(1)), a22*X(1)*polyval(Q2, X(1));
    a31*X(2), a31*X(1), 0];
B=[a13 0;
    a23*polyval(Q2, X(1)) 0;
    0 a32]; 
C=[0 1 0];
D=[0 0];
%расчет коэф-ов характеристического полинома м-цы А и его корней
%lmd = roots(poly(A))
%figure(2)
%plot (real (lmd), imag (lmd), '*'); grid
%Вывод графика расположения корней на комплексной плоскости.
% legend( 'complex');
% xlabel('Re');
% ylabel('Im');

%sim('model2.slx');
sim model2
sim model

figure(1)
hold on;
subplot(3,1,1);
d=plot(ans.x1(:, 1), ans.x1(:, 2)+X(1),'r-', ...
    x1(:, 1), x1(:, 2),'b-');grid on
title('x1(t) для СНЛАУ и СЛАУ');
legend('Ф СЛАУ','Ф СНЛАУ');
xlabel('t');
ylabel('Ф');
subplot(3,1,2);
e=plot(ans.x2(:, 1), ans.x2(:, 2)+X(2),'r--',...
    x2(:, 1), x2(:, 2),'b--'); grid on
title('x2(t) для СНЛАУ и СЛАУ');
legend('iд СЛАУ','iд СНЛАУ');
xlabel('t');
ylabel('iд');
subplot(3,1,3);
f=plot(ans.x3(:, 1), ans.x3(:, 2)+X(3),'r-.',...
    x3(:, 1), x3(:, 2),'b-.'); grid on
title('x3(t) для СНЛАУ и СЛАУ');
legend( 'w СЛАУ', 'w СНЛАУ');
xlabel('t');
ylabel('w');

set(d, 'LineWidth', 2)
set(e, 'LineWidth', 2)
set(f, 'LineWidth', 2)

Xl=[ans.x1(length(ans.x1), 2)+X(1),ans.x2(length(ans.x1),...
    2)+X(2),ans.x3(length(ans.x1), 2)+X(3)]
Xn=[x1(length(x1), 2),x2(length(x1), 2),x3(length(x1), 2)]
E=Xl-Xn 




