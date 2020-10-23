clc
T1=0.3;
T2=2;
T3=0.2;
k0=40;
b = 1.6;
c =20;

syms s w A real;
W1=1/(T1*s+1);
W2=1/(T2*s+1);
W3=1/(T3*s+1);
W=simplifyFraction(W1*W2*W3);
W=subs(W,s,1i*w);
re=simplify(real(W))
im=simplify(imag(W))

q=(4*c/(pi()*A))*(sqrt(1-(b/A)^2));
b1=-4*c*b/pi()/A^2;
Wne=(q+1i*b1);
Wne=-1/Wne;
rene=simplify(real(simplify(partfrac(Wne))))
imne=simplify(imag(simplify(partfrac(Wne))))

param{1}='A';
param{2}='w';
f=simplify((abs(rene-re)+abs(imne-im)));
fun = sym_to_matlabFunction(param,f);
x0=[1e-1 1e-1];
options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-10);
[A1,w1] = fminunc(fun,x0,options) 
%% graphic
print("проверка на совпадение");
rele1=double(subs(re,'w',w1))
imle1=double(subs(im,'w',w1))
rene1=double(subs(rene,'A',A1))
%  step=1e-2;
%  wz=0:step:1e1;
%  step=(max(A)-min(A))/100;
%  Am=step:step:max(A);
%     Cellfigparam{1}{1}='k-';
%     Cellfigparam{1}{2}=1;
%     Cellfigparam{2}{1}='k-';
%     Cellfigparam{2}{2}=2;
%     Cellfigparam{3}{1}='k--';
%     Cellfigparam{3}{2}=2;
% 
%   rele=double(subs(re,'w',wz));
%  imle=double(subs(im,'w',wz));
%  plot(rele,imle,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2});
%   hold on,grid on
%  rene1=subs(rene,'A',Am);
%  imne1=subs(imne,'A',Am);
%  plot(rene1,imne1,Cellfigparam{2}{1},'LineWidth',Cellfigparam{2}{2});
%  xlabel('Re'),ylabel('Im')
%% ручной поиск значения частоты и амплитуды по графику 
re1=-0.102;
im1=-0.0628;
Omega1=double(fminsearch(sym_to_matlabFunction('w',re-re1),1e-1))
Omega2=double(fminsearch(sym_to_matlabFunction('w',im-im1),1e-1))
Ampl1=double(fminsearch(sym_to_matlabFunction('A',rene-re1),2))
Ampl2=double(fminsearch(sym_to_matlabFunction('A',imne-im1),2))
Omega1=double(solve(re-re1,w))
 %% поверхность минимизируемой функции
%  step1=1e-1;
%  wz=0:step1:1e1;
%  step2=(max(A)-min(A))/2;
%  Am=0:step2:max(A)*3;
%    [X,Y]=meshgrid([0:step2:max(A)*3],[0:step1:1e1]);
%   for i=1:size(X,1) 
%    for j=1:size(Y,2)
%    cnac(i,j)=fun([X(i,j) Y(i,j)]); 
%    end
%   end
%  surf(X,Y,cnac)