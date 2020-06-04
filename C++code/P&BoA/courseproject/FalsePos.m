function [X,yX,resx,resy] = FalsePos(a,b,c,d,eps,xmin,xmax)

n=1;
m=1;
x(n)=xmin;
x(n+1)=xmax;
y(n)=f(a,b,c,d,x(n));
y(n+1)=f(a,b,c,d,x(n+1));
if y(n)*y(n+1)>0
    error('Уравнение с введенными коэффициентами не имеет решения в заданном интервале');
end
X=x(n)-y(n)*(x(n+1)-x(n))/(y(n+1)-y(n));
yX=f(a,b,c,d,X);
resx(m)=(x(n));
resx(m+1)=(x(n+1));
resx(m+2)=(X);
resy(m)=(y(n));
resy(m+1)=(y(n+1));
resy(m+2)=(yX);
if y(n)*yX>0
    x(n)=X;
    y(n)=yX;
else
    x(n+1)=X;
    y(n+1)=yX;
end
m=4;
while abs(yX)>eps
    X=x(n)-y(n)*(x(n+1)-x(n))/(y(n+1)-y(n));
    yX=f(a,b,c,d,X);
    if y(n)*yX>0
        x(n)=X;
        y(n)=yX;
    else
        x(n+1)=X;
        y(n+1)=yX;
    end
    resx(m)=(X);
    resy(m)=(yX);
    m=m+1;
end

end