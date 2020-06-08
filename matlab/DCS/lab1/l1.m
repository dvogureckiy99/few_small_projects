clc
%Ogureckiy Dmitriy VAR 7 Lab 1

%коэффициенты полиномов
b01=3;
a11=0.5;
a01=1;
b02=1;
a22=1;
a12=0.5;
a02=10;

%желаемый полином 
p = [1 -2.3209 1.8533 -0.5037];
%период дискретизации
Ts=0.12;
%time simulation 
end_time = 20;

W=tf(b01,[a11 a01])*tf(b02,[a22 a12 a02]);
S = ss(W)
Sd = c2d(S,Ts)
%Sd2 = c2d(W,Ts);
[A,B,C,D]=ssdata(S);
[Ad,Bd,Cd,Dd]=ssdata(Sd);
%[Ad1,Bd2,Cd1,Dd1]=ssdata(Sd2)

%modal regulator 7 punkt
I = eye(3);
p=roots(p);
Koc = place(Ad,Bd,p);
Adk = Ad-Bd*Koc ;
%Yust = b01*b02/(a01*a02);       %установившееся значение в непрерывной системе
Yust=C*((-A)^-1)*B  ; %2 способ
Rpr=(Yust-Dd)/(Cd*((I - Adk)^-1)*Bd);%установившееся значение в дискретной системе
                                   %с модальным регулятором
%8 punkt               
Bdk=Bd*Rpr;
Cdk=Cd;
Ddk=Dd;

Sdk=ss(Adk,Bdk,Cdk,Ddk,Ts)
%build graphics
step(Sd,'--r',S,'-b',Sdk,'-.g');
legend('Дискретная аналог системы','Непрерывная система','Дискретная аналог системы с модальным регулятором');
%open simulink model
open_system('CC.slx');
set_param('CC','StopTime','end_time','InitialStep','Ts');
sim('CC.slx');
open_system('CC/Scope');