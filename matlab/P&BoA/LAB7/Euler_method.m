function y =   Euler_method(a,b,c,d,h)
fid=fopen('Euler_method.txt','w');
fprintf(fid,'%6s %15s %20s\r\n','№','x','y');
n=30/h+1;%число итераций
x=zeros(1,n);%формирование массива
y=zeros(1,n);
fprintf(fid,'%6g %15g %20g\r\n',1,0,0);
i=2;%счётчик
while i<=n
    f=a*x(i-1)^3+b*x(i-1)^2+c*x(i-1)+d;
    y(i)=y(i-1)+h*f;
    x(i)=x(i-1)+h;
    fprintf(fid,'%6g %15g %20g\r\n',i,x(i),y(i));
     i=i+1;
end

fclose('all');
end
