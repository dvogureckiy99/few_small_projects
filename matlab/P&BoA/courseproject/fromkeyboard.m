function [a,b,c,d,eps,xmin,xmax] = fromkeyboard()

while(1)
    a=input('Введите коэффициент a\n');
    b=input('Введите коэффициент b\n');
    c=input('Введите коэффициент c\n');
    d=input('Введите коэффициент d\n');
    eps=input('Введите точность расчета\n');
    if eps<0
        error('Значение точности расчета должно быть положительным');
    end
    xmin=input('Введите значение интервала xmin\n');
    xmax=input('Введите значение интервала xmax\n');
    if xmin>xmax
        temp=xmin;
        xmin=xmax;
        xmax=temp;
    end
    exit=input('Если вы ввели верные данные, то введите "1",\nесли хотите повторить ввод, то введите "0"\n');
    if exit==(1)
        break
    end
end
clc

end

