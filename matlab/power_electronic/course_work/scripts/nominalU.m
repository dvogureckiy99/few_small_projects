clc 
clear

%начальные условия
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
xn=1;

tic;

Udmax=Udnom+Udnom*(dU1/100)
Udmin=Udnom-Udnom*(dU2/100)

Idnom=Udnom/Rdnom
Idmax=Udmax/Rdnom
Idmin=Udmin/Rdnom

Pdnom=Idnom*Udnom

%2.1.4
Ivsdnom=int(sym(Idnom),0,2*pi/3)/(2*pi)
Ivsmax=Idnom
Ivs=double(sqrt(int(sym(Idnom^2),0,2*pi/3)/(2*pi)))
%Ivs2=Idnom/sqrt(3)
U2f=U1f/k
Uvsobrmax=sqrt(6)*U2f
%4
Ivsdkr=double(Ivsdnom*1.5)
%2,1,5
syms a;
Uda=3*sqrt(6)*U2f*cos(a)/pi;
Udan=vpa(Uda/(subs(Uda,a,0)))
%параметры тиристора
rt=1.36*10^-3;
Utto=1.05;
%% 2.1.6
syms a;
Uda=3*sqrt(6)*U2f*cos(a)/pi;
Ud0=double(subs(Uda,a,0))
Id0=Ud0/Rdnom
I2f=Id0*sqrt(2/3)
S=m1*U2f*I2f

U1l=U1f*sqrt(3)
U2l=U2f*sqrt(3)
%6
%параметры трансформатора
Uktr=4.5;
Pkz=400;
I2n=I2f;
Z2f=Uktr*U2f/100/I2n
R2f=Pkz/m1/I2f^2
x2f=sqrt(Z2f^2-R2f^2)
L2f=x2f/w
%% 2.1.8
fprintf('------------------------------------2.1.8--------------------------\r');
amin=acos(Udmin*pi/3/sqrt(6)/U2f)
fprintf('alpha_min=%f \r',amin*180/pi);
anom=acos(Udnom*pi/3/sqrt(6)/U2f)
fprintf('alpha_nom=%f \r',anom*180/pi);
amax=acos(Udmax*pi/3/sqrt(6)/U2f)
fprintf('alpha_max=%f \r',amax*180/pi);
alpha=[amin*180/pi anom*180/pi amax*180/pi];
%% 2,1,9
syms a Id;
Udag=Ud0*cos(a)-Id*(m*x2f/2/pi+rt*2+R2f*2)-2*Utto;
%fprintf('Udag=%f при a=%f',double(subs(Udag,

% Cellfig{1} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
% hold on,grid on
%  xlabel('$I_d$','Interpreter','latex','FontSize',18),ylabel('$U_{d\alpha\gamma}$','Interpreter','latex','FontSize',18);
%  Cellfigparam{1}{1}='k-';
%     Cellfigparam{1}{2}=2;
%      Cellfigparam{2}{1}='k--';
%     Cellfigparam{2}{2}=1;
% %max
% y=vpa(subs(Udag,a, amax ));
% Idkr=double(solve(y,Id));
% Udnach=double(subs(y,Id,0));
% Idzn=0:1:Idkr;
% y=double(subs(y,Id, Idzn ));
% plot(Idzn,y,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2}); 
% limX=max(get(gca,'XTick'));
% %построение  линии начального напряжения и её подпись
% for i=1:limX
%    liney(i)= Udnach;
% end
% linex(1)=0;
% for i=2:limX
%     linex(i)= linex(i-1)+1;
% end
% text(limX/2,1.03*Udnach,['$U_d(I_d=0)=',num2str(Udnach,4),'B,\alpha_{max}=',num2str(alpha(3),2),'^{\circ}$'],'Interpreter','latex','FontSize',18);
% plot(linex,liney,Cellfigparam{2}{1},'LineWidth',Cellfigparam{2}{2});
% set(gca, 'YTick',0:1:max(get(gca,'YTick')));
% set(gca, 'XTick',0:200:limX);
% %min
% y=vpa(subs(Udag,a, amin ));
% Idkr=double(solve(y,Id));
% Udnach=double(subs(y,Id,0));
% Idzn=0:1:Idkr;
% y=double(subs(y,Id, Idzn ));
% plot(Idzn,y,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2}); 
% %построение  линии начального напряжения и её подпись
% for i=1:limX
%    liney(i)= Udnach;
% end
% linex(1)=0;
% for i=2:limX
%     linex(i)= linex(i-1)+1;
% end
% text(limX/2,1.03*Udnach,['$U_d(I_d=0)=',num2str(Udnach,4),'B,\alpha_{min}=',num2str(alpha(1),2),'^{\circ}$'],'Interpreter','latex','FontSize',18);
% plot(linex,liney,Cellfigparam{2}{1},'LineWidth',Cellfigparam{2}{2});
% %nom
% y=vpa(subs(Udag,a, anom ));
% Idkr=double(solve(y,Id));
% Udnach=double(subs(y,Id,0));
% Idzn=0:1:Idkr;
% y=double(subs(y,Id, Idzn ));
% plot(Idzn,y,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2}); 
% %построение  линии начального напряжения и её подпись
% for i=1:limX
%    liney(i)= Udnach;
% end
% linex(1)=0;
% for i=2:limX
%     linex(i)= linex(i-1)+1;
% end
% text(limX/2,1.03*Udnach,['$U_d(I_d=0)=',num2str(Udnach,4),'B,\alpha_{nom}=',num2str(alpha(2),2),'^{\circ}$'],'Interpreter','latex','FontSize',18);
% plot(linex,liney,Cellfigparam{2}{1},'LineWidth',Cellfigparam{2}{2});
% close(Cellfig{1}); %закрываем , чтобы не засорять память

%% 2.1.10
fprintf('---------------2.1.10---------------------\r');
gnom=acos(cos(anom)-Idnom*x2f*2/sqrt(6)/U2f)-anom
fprintf('gamma_nom=%f \r',gnom*180/pi);
fi1=anom+gnom/2
fprintf('fi1=%f \r',fi1*180/pi);
cosfi12=cos(fi1)
cosfi1=(cos(anom)+cos(anom+gnom))/2
% расчет Umax
fprintf('---------------гармоники выпр напр---------------------\r');
nu=1:3;
fnu=nu.*300
Ua0=Ud0.*2.*cos(0).*sqrt(1+nu.^2.*36.*tan(0))./(nu.^2.*36-1)
Uamin=Ud0.*2.*cos(amin).*sqrt(1+nu.^2.*36.*tan(amin))./(nu.^2.*36-1)
Uamax=Ud0.*2.*cos(amax).*sqrt(1+nu.^2.*36.*tan(amax))./(nu.^2.*36-1)
Uanom=Ud0.*2.*cos(anom).*sqrt(1+nu.^2.*36.*tan(anom))./(nu.^2.*36-1)
kpuls=2/(m^2+1)
fprintf('---------------гармоники тока---------------------\r');
I2fnom=Idnom*sqrt(2/3)
fprintf('-----------по формуле Зиновьева----------------\r');
n(1)=1;
for i=1:1
   n(2*i)=m*i-1;
   n(2*i+1)=m*i+1; 
end
I1fn=2.*sin(pi.*n./3).*Idnom./(pi.*3.*k.*sqrt(2).*n)
I1fnom=sqrt(sum(I1fn.^2))
I1fn1=I1fn(1)
KI=I1fn(1)/I1fnom
lamda=cosfi1*KI
%% КПД
fprintf('%s\r','-------------------------------------KPD');
Pvs=2*Utto*Ivsdnom
Ptr=2*R2f*I2fnom^2
Pvsp=0.4*Pdnom
Ppot=double(Pvs+Ptr+Pvsp)
kpd=double(Pdnom/(Pdnom+Ppot))
fprintf('Время выполнения: %.0f ms',toc*1000);