T1=0.3;
T2=2;
T3=0.2;
k0=40;
b = 1.6;
c =20;
syms s w real;
W1=K0/(T1*s+1);
W2=1/(T2*s+1);
W3=1/(T3*s+1);
W=simplifyFraction(W1*W2*W3)
W=subs(W,s,1i*w)
re=simplify(real(W))
im=simplify(imag(W))
%% graphic
step=1e-2;
wz=0:step:1e2;
rele=double(subs(re,'w',wz));
imle=double(subs(im,'w',wz));

    Cellfigparam{1}{1}='k-';
    Cellfigparam{1}{2}=1;
        Cellfigparam{2}{1}='k-';
    Cellfigparam{2}{2}=2;
hold on,grid on
plot(rele,imle,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2});

plot(1.5*imle-1/k,imle,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2});
xlabel('U^*'),ylabel('V^*')


