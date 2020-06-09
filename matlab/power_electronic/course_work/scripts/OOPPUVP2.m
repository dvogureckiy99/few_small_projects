%{  
Здесь строятся графики для разных значений Rn 
%}
clc
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');%шрифт
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); %
%t = pi/6:pi/180:pi ;
U2fm=200*sqrt(2);
hold on;
for Rn=0.050:0.010:1
L=100*10^-6;
alpha=pi/6;
w=100*pi;
tau=L/Rn;
syms x ;
%расчёт через временную область
A=U2fm*(L*w*cos(alpha)-Rn*sin(alpha))/(Rn^2+L^2*w^2);
iLvin=U2fm*(-L*w*cos(x)+Rn*sin(x))/(Rn^2+L^2*w^2);
iL=A*exp(-(x-alpha)/(w*tau))+iLvin;

iLpi1=double(subs(iL,x,pi))
%расчет по Лапласу 
syms s;
H=1/(Rn+L*s);
Uvh=U2fm*(s*sin(alpha)+w*cos(alpha))/(s^2+w^2);
Uvuh=Uvh*H;
syms t;
iL3=ilaplace(Uvuh);
iL3=subs(iL3,t,x/w);
iLpi2=double(subs(iL3,x,(pi-alpha)))
iL3=subs(iL3,x,x-alpha);


%graphics
k=2;

%subplot(2,2,1);
%{
p1 = fplot(iL,[alpha pi*k],'Color','b','LineStyle',':');grid on
p1.LineWidth = 2;
title('ПХ')
xlabel('wt,рад'),ylabel('iL,А')
%}

%subplot(2,2,2);
p2 = fplot(iL3,[alpha pi*k]);grid on
%'Color','r','LineStyle','--'
p2.LineWidth = 2;
title('ПХ')
xlabel('wt,рад'),ylabel('iL,А')
legend( ['Rn =' num2str(Rn)]);
%legend(Rn,'Location','southoutside') ;
%legend('Во временной области','По Лаплассу','Location','southoutside') ;
end
