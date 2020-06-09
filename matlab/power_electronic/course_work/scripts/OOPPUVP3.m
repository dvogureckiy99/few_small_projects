%{  
«десь расчет t2 времени включени¤ тиристора
%}
clc
syms Rn L aplha w tau t2 ;
tau=L/Rn ;
A=U2fm*(L*w*cos(alpha)-Rn*sin(alpha))/(Rn^2+L^2*w^2);
iLvin=U2fm*(-L*w*cos(w*t2)+Rn*sin(w*t2))/(Rn^2+L^2*w^2);
iL=A*exp(-(w*t2-alpha)/(w*tau))+iLvin;
solve(iL==0, t2)