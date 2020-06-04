function [a,b,c,d,eps,xmin,xmax] = fromfile()

fileIn=fopen('input.txt','r');
a=fscanf(fileIn,'%f',1);
b=fscanf(fileIn,'%f',1);
c=fscanf(fileIn,'%f',1);
d=fscanf(fileIn,'%f',1);
eps=fscanf(fileIn,'%f',1);
if eps<0
    error('Значение точности расчета должно быть положительным');
end
xmin=fscanf(fileIn,'%f',1);
xmax=fscanf(fileIn,'%f',1);
if xmin>xmax
    temp=xmin;
    xmin=xmax;
    xmax=temp;
end
fclose(fileIn);

end

