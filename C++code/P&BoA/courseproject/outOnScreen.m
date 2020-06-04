function [] = outOnScreen(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method)

disp('Значения коэффициентов уравнения')
fprintf('a = %g , b = %g , c = %g , d = %g\n',a,b,c,d);
disp('Интервал')
fprintf('%g <= x <= %g\n',xmin,xmax);
disp('Значение точности')
fprintf('epsilon = %g\n',eps);
fprintf('Метод %s\n',method);
disp('Корень:')
disp(ansx)
disp('Значения x          Значения y')
for m=1:length(resx);
    fprintf('x(%d)=%-5.3f   \ty(%d)=%-5.3f\n',m,resx(m),m,resy(m));
end
    
end