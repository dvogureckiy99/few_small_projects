clear 
clc
Cellfig{1} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
hold on,grid on
 xlabel('$\alpha,rad$','Interpreter','latex','FontSize',14),ylabel('$U_{d\alpha}^*$','Interpreter','latex','FontSize',14);
 Cellfigparam{1}{1}='k-';
 Cellfigparam{1}{2}=2;
 x=0:0.01:(pi/2);
 y=cos(x);
 plot(x,y,Cellfigparam{1}{1},'LineWidth',Cellfigparam{1}{2});