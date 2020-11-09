% s = tf('s');
% W=3*s/(1+3*s);
% w=1e-2:1e-2:1e2;

%a = [2 5 6 2 1 0];
a = [4 7 6 1];
W=tf(a,1);
w=1e-2:1e-2:2;
%nyquist(W,w);
godMih(W,w);


