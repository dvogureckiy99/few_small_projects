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
            if (a~=0||b~=0||c~=0||d~=0||h~=0)
           finding_the_root_x1(a,b,c,d,h)
           finding_the_root_x2(a,b,c,d,h)
           enter = menu('������ ����������?','��','���');
            else
                enter = menu('�� �� ����� �������� ������, ������ ����������?','��','���');
            end
    end      
end