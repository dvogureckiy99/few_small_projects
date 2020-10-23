function graph_variable_structure1(x,y,t,PATH,figure_name)
%строит график
 set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');%шрифт
 set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); %
 
fig=figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
 
p(1)=plot(x,y,'black-');grid on
xlabel('x'),ylabel('y(x)=dx/dt')
% legend( ['ПХ по скорости с нелинейным элементом' ]...
%     'Location','southoutside','Box','off' ) 

p(1).LineWidth = 2;

prints(figure_name,PATH.images); %save to pdf and crop with dos 
close(fig); %закрываем , чтобы не засорять память
%open ([PATH.images,figure_name,'.pdf']);

end
