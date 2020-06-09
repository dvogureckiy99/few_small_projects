function[] = finding_the_root_x1(a,b,c,d,E)
x=[0 30];
y=a.*x.^3+b.*x.^2+c.*x+d;
if y(1)*y(2)>0
    disp('на этом интервале корней нет')
    noroot=true;
else
    noroot=false;
end
if ~noroot
y_sr = inf; 
n=0; %счётчик
x_sr=0;
fid=fopen('root_x1.txt','w');
fprintf(fid,'%6s %15s %20s\r\n','№','x','y');
while abs(y_sr)>E
    x_sr = (x(1)+x(2))/2;
    y_sr = a.*x_sr.^3+b.*x_sr.^2+c.*x_sr+d;
    if y(1)*y_sr>0
        x(1)=x_sr;
        y(1)=y_sr;
    else
        x(2)=x_sr;
    end
    n=n+1;
    fprintf(fid,'%6g %15g %20g\r\n',n,x_sr,y_sr);
end
   x_sr
   fclose('all');
end
end