function godMih(W,w)
 set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');%шрифт
if nargin > 1
disp(nargin);
[re,im] = nyquist(W,w);
else
[re,im] = nyquist(W);
end
% Приведение к одномерному массиву (см. help squeeze)

re2 = squeeze(re);

im2 = squeeze(im);

% --------------------------------------------

figure(2);

% Построение АФХ

line(re2,im2,'linew',2)

grid on

title('\bf\fontsize{12} Амплитудно-фазовая характериcтика')

xlabel('\bf\fontsize{12} Действительная ось')

ylabel('\bf\fontsize{12} Мнимая ось')

set(gcf,'color','w')
end