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
decision = menu('�������� ��������?','������ ������������ ���������','������ ��� ��������������','������ ���������');
    switch decision
         case 1
             a = input('������� �����. �');
             b = input('������� �����. b');
             c = input('������� �����. c'); 
             d = input('������� �����. d');
        case 2
            h = input('������� ��� ��������������');
        case 3
            if ((a~=0||b~=0||c~=0||d~=0)&&h~=0)
           y_Euler_method = Euler_method(a,b,c,d,h) ;
           y_Runge_Kutta_method =  Runge_Kutta_method(a,b,c,d,h);
           y_analytical_method = analytical_method(a,b,c,d,h);
           x=massiv_x(h);
           plot(x,y_Euler_method,'-b',x,y_analytical_method,'-r',x,y_Runge_Kutta_method,'-g')
           legend('������ ������ ������','������ �������������� ������','������ ������ �����-����� 2 �������')
           grid 
           title('������� �������')
           xlabel('x')
           ylabel('y(x)')
           enter = menu('������ ����������?','��','���');
            else
                enter = menu('�� �� ����� �������� ������, ������ ����������?','��','���');
            end
    end      
end