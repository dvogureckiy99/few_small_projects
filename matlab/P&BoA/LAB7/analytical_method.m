function y = analytical_method(a,b,c,d,h)
fid=fopen('analytical_method.txt','w');
fprintf(fid,'%6s %15s %20s\r\n','№','x','y');
n=30/h+1; %количество итераций
x=zeros(1,n);
y=zeros(1,n);
i=1; %счётчик
while i<=n
    y(i)=a*x(i)^4/4+b*x(i)^3/3+c*x(i)^2/2+d*x(i);
    fprintf(fid,'%6g %15g %20g\r\n',i,x(i),y(i));
    x(i+1)=x(i)+h;
     i=i+1;
end

 fclose('all');
end