function [] = outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method)

disp('�������� ������������� ���������')
fprintf('a = %g , b = %g , c = %g , d = %g\n',a,b,c,d);
disp('��������')
fprintf('%g <= x <= %g\n',xmin,xmax);
disp('�������� ��������')
fprintf('epsilon = %g\n',eps);
fprintf('����� %s\n',method);
disp('������:')
disp(ansx)
disp('�������� x          �������� y')
for m=1:length(resx);
    fprintf('x(%d)=%-5.3f   \ty(%d)=%-5.3f\n',m,resx(m),m,resy(m));
end
    
end