function [a,b,c,d,eps,xmin,xmax] = fromkeyboard()

while(1)
    a=input('������� ����������� a\n');
    b=input('������� ����������� b\n');
    c=input('������� ����������� c\n');
    d=input('������� ����������� d\n');
    eps=input('������� �������� �������\n');
    if eps<0
        error('�������� �������� ������� ������ ���� �������������');
    end
    xmin=input('������� �������� ��������� xmin\n');
    xmax=input('������� �������� ��������� xmax\n');
    if xmin>xmax
        temp=xmin;
        xmin=xmax;
        xmax=temp;
    end
    exit=input('���� �� ����� ������ ������, �� ������� "1",\n���� ������ ��������� ����, �� ������� "0"\n');
    if exit==(1)
        break
    end
end
clc

end

