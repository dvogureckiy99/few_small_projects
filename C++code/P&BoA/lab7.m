%lab2
clear
clc
close
x=-4:0.1:8;
f=((exp(x)+exp(-2.*x)).*sin(x))./(x.^2+1) ;
subplot(121)
plot(x,f)
grid
title('график функции f(x)')
xlabel('x')
ylabel('f(x)')
P1=[0 1 2 3 2];
P2=[1 3 2 2 9];
w=logspace(-2,2,70);
s=1i*w;
F=angle(polyval(P1,s)./polyval(P2,s));
subplot(122)
semilogx(w,F)
grid 
title('График фазы функции комплексной переменной')
xlabel('мнимая часть комплексной переменной')
ylabel('фаза функции к.п.')
