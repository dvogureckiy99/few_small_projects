index=zeros(1,4);
while index(1)~=1||index(2)~=1||index(3)~=1||index(4)~=1
    m=menu('Введите коэффициенты','a','b','c','d');
    switch m
        case 1
        a=input('a=');
        index(1)=1;
        case 2
        b=input('b=');
        index(2)=1;
        case 3
        c=input('c=');
        index(3)=1;
        case 4
        d=input('d=');
        index(4)=1;   
    end
end
vvodpogr=menu('Введите погрешность','e');
e=input('e=');
m=menu('Выберите метод решения','Метод половинного деления','Метод ложного положение');
if m==1
    poldel(a,b,c,d,e)
end
if m==2
    lozhnpol(a,b,c,d,e)
end