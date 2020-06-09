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
            if ((a~=0||b~=0||c~=0||d~=0)&&h~=0)
           y_Euler_method = Euler_method(a,b,c,d,h) ;
           y_Runge_Kutta_method =  Runge_Kutta_method(a,b,c,d,h);
           y_analytical_method = analytical_method(a,b,c,d,h);
           x=massiv_x(h);
           plot(x,y_Euler_method,'-b',x,y_analytical_method,'-r',x,y_Runge_Kutta_method,'-g')
           legend('график метода Эйлера','график аналитического метода','график метода Рунге-Кутты 2 порядка')
           grid 
           title('Графики функций')
           xlabel('x')
           ylabel('y(x)')
           enter = menu('хотите продолжить?','да','нет');
            else
                enter = menu('Вы не ввели исходные данные, хотите продолжить?','да','нет');
            end
    end      
end