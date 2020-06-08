clear
clc
close all
filename = 'data.xlsx';
sheet = 1;
izm=8;
last=izm+1;

%перенос массивов
col='A';
I1Range = [col,num2str(2),':',col,num2str(last)];
I1 = readmatrix(filename,'Sheet',sheet ,'Range',I1Range);
col='B';
cosphiRange = [col,num2str(2),':',col,num2str(last)];
cosphi = readmatrix(filename,'Sheet',sheet ,'Range',cosphiRange);
col='C';
sRange = [col,num2str(2),':',col,num2str(last)];
s = readmatrix(filename,'Sheet',sheet ,'Range',sRange);
col='E';
M2Range = [col,num2str(2),':',col,num2str(last)];
M2 = readmatrix(filename,'Sheet',sheet ,'Range',M2Range);
col='F';
nuRange = [col,num2str(2),':',col,num2str(last)];
nu = readmatrix(filename,'Sheet',sheet ,'Range',nuRange);
col='P';
n2Range = [col,num2str(2),':',col,num2str(last)];
n2 = readmatrix(filename,'Sheet',sheet ,'Range',n2Range);
col='O';
P1Range = [col,num2str(2),':',col,num2str(last)];
P1 = readmatrix(filename,'Sheet',sheet ,'Range',P1Range);
col='D';
P2Range = [col,num2str(2),':',col,num2str(last)];
P2 = readmatrix(filename,'Sheet',sheet ,'Range',P2Range);

data=[P2 cosphi P1 M2 I1 nu n2 s];

data = sortrows(data,1); %сортируем все данные  P2 по возрастанию и мен¤ем остальные , т.к. по нему строим

    Cellfigparam{1}{1}='k-';
    Cellfigparam{1}{2}=2;
    Cellfigparam{1}{3}='ko';
    Cellfigparam{2}{1}='k--';
    Cellfigparam{2}{2}=2;
    Cellfigparam{2}{3}='k+';
    Cellfigparam{3}{1}='k-.';
    Cellfigparam{3}{2}=1;
     Cellfigparam{3}{3}='k.';
    Cellfigparam{4}{1}='k--';
    Cellfigparam{4}{2}=1;
     Cellfigparam{4}{3}='k*';
    Cellfigparam{5}{1}='k-.';
    Cellfigparam{5}{2}=2;
     Cellfigparam{5}{3}='kx';
    Cellfigparam{6}{1}='k-';
    Cellfigparam{6}{2}=1;
     Cellfigparam{6}{3}='ks';
    Cellfigparam{7}{1}='k:';
    Cellfigparam{7}{2}=2;
     Cellfigparam{7}{3}='kd';
    
    ylabel{1}='cos(\phi_1)';
    ylabel{2}='P_1';
    ylabel{3}='M_2';
    ylabel{4}='I_1';
    ylabel{5}='\eta';
    ylabel{6}='n_2';
    ylabel{7}='s';
  
    
 set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');%шрифт
  Cellfig{1} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
  figure(Cellfig{1});%target figure
sdvig = 0;%// distance to squeeze the first plot
  step = 2;
  x=data(:,1);
  for i=1:7
%set(the_axes, 'NextPlot', 'add');
%title(the_axes, ylabel{1},'Interpreter','latex');
%// generate two axes at same position 

% ax = axes(Cellfig{1},'Units','centimeters'); 
% pos =  get(ax, 'Position');
% pos(1) = pos(1)-sdvig; 
% ax = axes('Units','centimeters','Position',pos,'Color','none'); 
% 
    ax{i} = axes('Units','centimeters');

     grid on ,hold on   
     y= data(:,i+1);
%     %интерпол¤ци¤ 
     
    switch i
%         case 1
%         xx = 0:100:max(data(:,1));
%         [d,index]=unique(x); 
%         yy = interp1(d,y(index),xx, 'pchip');
%         case 2
%            xx = 0:100:max(data(:,1));
%         [d,index]=unique(x); 
%         yy = interp1(d,y(index),xx, 'pchip'); 
%         case 3
%              xx = 0:1:max(data(:,1));
%         [d,index]=unique(x); 
%         yy = interp1(d,y(index),xx, 'linear');
%         case 4
%               xx = 0:200:max(data(:,1));
%         [d,index]=unique(x); 
%         yy = interp1(d,y(index),xx, 'pchip');
        case 5
           maxim =max(data(:,1)) ; 
       p= polyfit(x,y,2);
         xx = 0:10:maxim ;
        yy = polyval(p,xx);
        case 6
            maxim =max(data(:,1)) ; 
       p= polyfit(x,y,1);
         xx = [0 maxim/2 maxim ];
        yy = polyval(p,xx);
%         case 7
%             xx = 0:200:max(data(:,1));
%         [d,index]=unique(x); 
%         yy = interp1(d,y(index),xx, 'pchip');
    end
     
    if i==6||i==5
        plot(ax{i},xx,yy,Cellfigparam{i}{1},'DisplayName',ylabel{1},'LineWidth',Cellfigparam{i}{2});
    end     
          plot(ax{i},x,y,Cellfigparam{i}{3},'MarkerSize',6);
          
      
      leg{i}=legend(ax{i}, {['$',ylabel{i},'$']},'Interpreter','latex','Units','centimeters');
      posa = get(ax{i},'position');
      
      posa = posa+[ -3+7*step 0.5 -1+3-7*step -1.5];
      
       scale_factor = 1; %// change this to your satisfaction
      Ylim = (get(ax{i}, 'YLim') * scale_factor) ;
        Ylim=[Ylim(1)-Ylim(1) Ylim(2)]; %ymin = 0
      set(ax{i},'Units','centimeters','position',posa,'Box','off','Color','none','Ylim', Ylim);
      
      if i>1
         set(ax{i}, 'XTick',[],'YTick',[]);
         posa2 = posa + [-sdvig 0 sdvig 0] ;
          ax2 = axes('Units','centimeters','Position',posa2,'Color','none','Box','off');
          
          set(ax2, 'YScale', get(ax{i}, 'YScale'),'Ylim', Ylim, 'XTick',[]  ); %// make logarithmic if first axis is too
           if i~=7
               clear YTick YTickLabel;
              YTL = get(ax2,'YTickLabel');
              YT = get(ax2,'YTick');
              for j=2:length(YT)
                 YTick(j-1)=YT(j);
                 YTickLabel{j-1}=YTL{j};
              end
              
          set(ax2, 'YTick',YTick,'YTickLabel',YTickLabel); 
           end
      end
      if i==1 
                  %  clear YTick YTickLabel;
                  YTL = get(ax{i},'YTickLabel');
                  YT = get(ax{i},'YTick');
                  for j=2:length(YT)
                     YTick(j-1)=YT(j);
                     YTickLabel{j-1}=YTL{j};
                  end
                
            set(ax{i}, 'YTick',YTick,'YTickLabel',YTickLabel);
      end  
       
%          ax2.YLabel.String = label;
%           ylabel(label);
         % set(ax2,'Ylabel', label);
         
      
      txt = ['$',ylabel{i},'$'];
          posl=[0 posa(4)+0.5 ];
          text('String',txt,'Position',posl,'Units','centimeters','FontSize',14,'Interpreter','latex');
      %set(ax{i},'Color','none');
      if i==1
      xlabel('$$P_2$$','Interpreter','latex') ;
      
      end
    pos=get(leg{i},'position');
    pos(1) = posa(3)+posa(1); 
    set(leg{i},'Units','centimeters','position',pos+[ 1 -pos(4)*(i-1) 0 0]);
      sdvig = sdvig +step;
  end
  
  %set(ax,'YAxisLocation','right') 

%   legend(the_axes, leg,'Interpreter','latex','Location','southoutside');

% name = 'graph';
% folder = 'D:\education\6_sem\Electrical_mashines\labs\7\';
% prints(name,folder,Cellfig{1});
% winopen([folder,name]);
%  close(Cellfig{1}); %закрываем , чтобы не засор¤ть пам¤ть


