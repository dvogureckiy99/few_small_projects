function[]=poldel(a,b,c,d,e)
x=0:30;
y=znach(x,a,b,c,d);
for i=1:30
if sign(y(i))~= sign(y(i+1))
    noroot=0;
    break
else
    noroot=1;
end
end
if noroot==1
    disp('Нет корней на промежутке');
else
fid=fopen('answerpoldel.txt','w');
midleznach=y(i);
shag=0;
fprintf(fid,'%6s %12s %18s\r\n','№','x','y');
while abs(midleznach)>=e
shag=shag+1;
midle=(x(i)+x(i+1))/2;
midleznach=znach(midle,a,b,c,d);
if sign(midleznach)~=sign(y(i))
    x(i+1)=midle;
else
    x(i)=midle;
end
fprintf(fid,'%6g %12g %18g\r\n',shag,midle,midleznach);
end
fclose(fid);
disp(midle);
end