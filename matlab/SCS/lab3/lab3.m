% Lab2
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

% коэффициенты 
a11=-(i_n*(r_v+r_j))/(N*P_n);
a12=-c_e*w_n/N;
a13=U_sn/(N*P_n);
a21=a11;
a22=a12;
a23=a13;
a31=c_m*P_n*i_n/(J*w_n);
a32=-M_sn/(J*w_n);
% производная от полинома p(Ф)
Q2=[-0.381 0 2.292 0 0.3415];

% симуляция
sim('model.slx')

% построение фазовых портретов
figure(1)
subplot(2,2,1)
plot(x2(:, 2), x1(:, 2),'LineWidth',1.5), grid, 
title('x1(x2)');
xlabel('iд');
ylabel('Ф');
subplot(2,2,2)
plot(x3(:, 2), x1(:, 2),'LineWidth',1.5), grid, 
title('x1(x3)');
xlabel('w');
ylabel('Ф');
subplot(2,2,3)
plot(x3(:, 2), x2(:, 2),'LineWidth',1.5), grid, 
title('x2(x3)');
xlabel('w');
ylabel('iд');

% график переходного процесса
figure(2)
d=plot(x1(:, 1), x1(:, 2),'-', ...
     x2(:, 1), x2(:, 2),'--',  ...
     x3(:, 1), x3(:, 2),'-.');
grid 
set(d, 'LineWidth', 2)
title('x1(t), x2(t), x3(t)');
xlabel('t');
ylabel('Ф, iд, w');
legend('Ф', 'iд', 'w');
X1=x1(1001, 2)
X2=x2(1001, 2)
X3=x3(1001, 2)
