function [xcp,ycp,resx,resy] = Bisection(a,b,c,d,eps,xmin,xmax)

n=1;
m=1;
x(n)=xmin;
x(n+1)=xmax;
y(n)=f(a,b,c,d,x(n));
y(n+1)=f(a,b,c,d,x(n+1));
if y(n)*y(n+1)>0
    error('Уравнение с введенными коэффициентами не имеет решения в заданном интервале');
end
xcp=(x(n)+x(n+1))/2;
ycp=f(a,b,c,d,xcp);
resx(m)=(x(n));
resx(m+1)=(x(n+1));
resx(m+2)=(xcp);
resy(m)=(y(n));
resy(m+1)=(y(n+1));
resy(m+2)=(ycp);
if y(n)*ycp>0
    x(n)=xcp;
    y(n)=ycp;
else
    x(n+1)=xcp;
    y(n+1)=ycp;
end
m=4;
while abs(ycp)>eps
    xcp=(x(n)+x(n+1))/2;
    ycp=f(a,b,c,d,xcp);
    if y(n)*ycp>0
        x(n)=xcp;
        y(n)=ycp;
    else
        x(n+1)=xcp;
        y(n+1)=ycp;
    end
    resx(m)=(xcp);
    resy(m)=(ycp);
    m=m+1;
end

end