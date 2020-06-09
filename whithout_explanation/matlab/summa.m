function sum = summa(a,b,varargin)
global c
i = 2
while i<nargin
sum=a+b+c+varargin(i-1);
i=i+1;
end
end