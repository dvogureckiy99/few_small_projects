function[] = finding_the_root_x2(a,b,c,d,E)
x=[0 30];
y=a.*x.^3+b.*x.^2+c.*x+d;
if y(1)*y(2)>0
    disp('на этом интервале корней нет')
    noroot=true;
else
    noroot=false;
end
if ~noroot
y_intersection = inf; 
x_intersection = 0; %точка пересечения прямой с осью абсцисс
n=0; %счётчик
fid=fopen('root_x2.txt','w');
fprintf(fid,'%6s %15s %20s\r\n','№','x','y');
while abs(y_intersection)>E
    x_intersection = x(1)-y(1)*(x(2)-x(1))/(y(2)-y(1));
    y_intersection = a.*x_intersection.^3+b.*x_intersection.^2+c.*x_intersection+d;
    if y(1)*y_intersection>0
        x(1)=x_intersection;
        y(1)=y_intersection;
    else
        x(2)=x_intersection;
        y(2)=y_intersection;
    end
    n=n+1;
    fprintf(fid,'%6g %15g %20g\r\n',n,x_intersection,y_intersection);
end
   x_intersection
   fclose('all');
end
end

