clear
enter=1;
a=0;
b=0;
c=0;
d=0;
h=0;
while enter==1
 clc
a
b
c
d
h
decision = menu('Желаемая операция?','ввести коэффициенты уравнения','ввести шаг интегрирования','решить уравнение');
    switch decision
         case 1
             a = input('Введите коэфф. а');
             b = input('Введите коэфф. b');
             c = input('Введите коэфф. c'); 
             d = input('Введите коэфф. d');
        case 2
            h = input('Введите шаг интегрирования');
        case 3
            if (a~=0||b~=0||c~=0||d~=0||h~=0)
           finding_the_root_x1(a,b,c,d,h)
           finding_the_root_x2(a,b,c,d,h)
           enter = menu('хотите продолжить?','да','нет');
            else
                enter = menu('Вы не ввели исходные данные, хотите продолжить?','да','нет');
            end
    end      
end