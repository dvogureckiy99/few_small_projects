function [] = outInFile(a,b,c,d,eps,xmax,xmin,resx,resy,ansx,method)

fileout=fopen('output.txt','a');
fprintf(fileout,'�������� ������������� ���������\n');
fprintf(fileout,'a = %g , b = %g , c = %g , d = %g\n',a,b,c,d);
fprintf(fileout,'��������\n');
fprintf(fileout,'%g <= x <= %g\n',xmin,xmax);
fprintf(fileout,'�������� ��������\n');
fprintf(fileout,'epsilon = %g\n',eps);
fprintf(fileout,'����� %s\n',method);
fprintf(fileout,'������:\n');
fprintf(fileout,'%g\n',ansx);
fprintf(fileout,'�������� x          �������� y\n');
for m=1:length(resx);
    fprintf(fileout,'x(%d)=%-5.3f   \ty(%d)=%-5.3f\n',m,resx(m),m,resy(m));
end
fclose(fileout);
end

