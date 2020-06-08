clc 
clear

%% начальные условия
Udnom=12;
dU1=10;
dU2=20;
Rdnom=0.04;
dRd1=-0.01;
dRd2=0.04;
U1f=230;
k=25;
f=50;
w=2*pi*f;
m1=3;
m=6;
E=7;

U2f=U1f/k
%% параметры тиристора
rt=1.36*10^-3;
Utto=1.05;

tic;
U2fmax=U2f*sqrt(2)
Ekl=4*E/U2fmax
lambda_max=2*acos(E/U2fmax)
fprintf('lambda_max=%f \r',lambda_max*180/pi);
fprintf('lambda_max/2=%f \r',lambda_max*180/2/pi);
anom=acos(Udnom*pi/U2f/3/sqrt(6))+lambda_max/2-pi/3
fprintf('anom=%f \r',anom*180/pi);
Un=Udnom-E
Idnom=(Udnom-E)/Rdnom
Ivsdnom=double(int(sym(Idnom),0,2*pi/3)/(2*pi))
%% параметры трансформатора
syms a;
Uda=3*sqrt(6)*U2f*cos(a-lambda_max/2+pi/3)/pi;
Ud0=double(subs(Uda,a,0))
Id0=Ud0/Rdnom
I2f=Id0*sqrt(2/3)


Uktr=4.5;
Pkz=400;
I2n=I2f;
Z2f=Uktr*U2f/100/I2n
R2f=Pkz/m1/I2f^2
x2f=sqrt(Z2f^2-R2f^2)
L2f=x2f/w
%% КПД
fprintf('%s\r','-------------------------------------KPD');
Pdnom=Idnom*Un
Pvs=double(2*Utto*Ivsdnom)
I2fnom=Idnom*sqrt(2/3)
Ptr=2*R2f*I2fnom^2
Pvsp=0.4*Pdnom
Ppot=double(Pvs+Ptr+Pvsp)
kpd=double(Pdnom/(Pdnom+Ppot))
%cos(-lambda_max/2+pi/3)
fprintf('Время выполнения: %.0f ms',toc*1000);