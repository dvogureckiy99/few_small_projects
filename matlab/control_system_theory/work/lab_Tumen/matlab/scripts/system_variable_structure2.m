function FIGS = system_variable_structure2(InitialConditions,PATH,FIGS)
name_system = 'sim_variable_structure2';                 %имя схемы

%имя и путь графика для Latex
% фазовые траектории
figure_name = [strrep(name_system,'sim_',''),'_tau1'];%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
FIGS.names{4} = figure_name ;
FIGS.path{4}=figure_file_path;
FIGS.description{4}=' Фазовые траектории для системы с переменной структурой с разными начальными условиями($\tau_1$).';

% Переменные состояния
figure_name = [strrep(name_system,'sim_',''),'_sys_tau1'];%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
FIGS.names{5} = figure_name ;
FIGS.path{5}=figure_file_path;
FIGS.description{5}=' Графики изменения переменных состояния($\tau_1$).';

% фазовые траектории
figure_name = [strrep(name_system,'sim_',''),'_tau2'];%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
FIGS.names{6} = figure_name ;
FIGS.path{6}=figure_file_path;
FIGS.description{6}=' Фазовые траектории для системы с переменной структурой с разными начальными условиями($\tau_2$).';
% Переменные состояния
figure_name = [strrep(name_system,'sim_',''),'_sys_tau2'];%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
FIGS.names{7} = figure_name ;
FIGS.path{7}=figure_file_path;
FIGS.description{7}=' Графики изменения переменных состояния($\tau_2$).';
handle = load_system(name_system); %загрузка схемы

%установка параметров
tau(1)=sqrt(InitialConditions.k)*2;%условие колебаний
tau(2)=sqrt(InitialConditions.k)/2;%условие апериодическое
k1 = 1;
k2 =-1;
x0 = 0;
y0 = 0;
FStep=10^-4;
Cellfigparam{1}='black-';
Cellfigparam{2}='black-';
Cellfigparam{3}='black--';
ymax=0;
ymin=0;
for j=1:2 %проводим эксперимент при 2 tau 
    Cellfig{2} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
    Cellfig{3} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
    for k=0:2
        x0=0.1*k;
       y0=x0;

    %перенос переменных в основную базу переменных
    assignin('base','end_time',20);%------------------------------------------------------------------время симуляции
    assignin('base','k1',k1);
    assignin('base','k2',k2);
    assignin('base','tau',tau(j));
    assignin('base','x0',x0);
    assignin('base','y0',y0);
    assignin('base','FStep',FStep);

    set_param(handle,'StopTime','end_time' ,'SolverPrmCheckMsg','warning'...
        ,'SolverResetMethod','robust','Solver','ode113','SolverType','Fixed-step','FixedStep','FStep',...
        'SaveFormat','Array','SaveOutput','off','ReturnWorkspaceOutputs','off')

    %возвращает сигналы в массиве b в п7орядке согласно номерам портов
    [t,~,x,y] = sim(name_system);
    assignin('base','x',x);
    assignin('base','y',y);

    %расчёт максимума и минимума  y из всех значений
    if ymax<max(y)
    ymax=max(y);
    end
    if ymin>min(y)
    ymin=min(y);
    end
    figure(Cellfig{2});%target figure
    plot(x,y,Cellfigparam{k+1},'LineWidth',1);grid on, hold on
    if k==2
        step=(ymax-ymin)/21;
        plot([ymin/(-sqrt(InitialConditions.k)) ymax/(-sqrt(InitialConditions.k))],[ymin ymax],'k:','LineWidth',1);%строим прямую сепаратрисы седловой траектории
        if k~=0
        txt = ['$$y\,=\,-\,\sqrt{k}\,x$$'];   
        text(ymax/1.7/(-sqrt(InitialConditions.k)), ymax/1.7+step ,txt,'Interpreter','latex'); %подпись
        end
        plot([ymin/(-tau(j)) ymax/(-tau(j))],[ymin ymax],'k:','LineWidth',1);%строим прямую линией скольжения
        if k~=0
            if j==1
                txt = ['$$y\,=\,-\,\tau_1\,x$$'];  
            else
                txt = ['$$y\,=\,-\,\tau_2\,x$$']; 
            end
        text(ymax/1.5/(-tau(j)), ymax/1.5+step ,txt,'Interpreter','latex'); %подпись
        end
        xlabel('x'),ylabel('y(x)=dx/dt')
        title(['$$\tau_',num2str(j,0),'=',num2str(tau(j),3),'$$'],'Interpreter','latex');  
    end
    % legend( ['ПХ по скорости с нелинейным элементом' ]...
    %     'Location','southoutside','Box','off' ) 
    plot(x(1),y(1),'kx','MarkerFaceColor','k','MarkerSize',10);grid on, hold on

    % p(1).LineWidth = 2;
    %graph_variable_structure1(x,y,t,PATH,figure_name);%строит график

    figure(Cellfig{3});%target figure
    subplot(1,2,1);
    plot(t,y,Cellfigparam{k+1});grid on,hold on ;title(['$$\tau_',num2str(j,0),'=',num2str(tau(j),3),'$$'],'Interpreter','latex');  
    xlabel('t'),ylabel('y(x)=dx/dt')
    subplot(1,2,2);
    plot(t,x,Cellfigparam{k+1});grid on,hold on ;title(['$$\tau_',num2str(j,0),'=',num2str(tau(j),3),'$$'],'Interpreter','latex');  
    xlabel('t'),ylabel('x')
    % for a=2:3
    %    p(a).LineWidth = 2;
    % end

    end
    prints(FIGS.names{4+j*2-2},PATH.images,Cellfig{2}); %save to pdf and crop with dos
    prints(FIGS.names{5+j*2-2},PATH.images,Cellfig{3}); %save to pdf and crop with dos
    close(Cellfig{2}); %закрываем , чтобы не засорять память
    close(Cellfig{3}); %закрываем , чтобы не засорять память
end
%% 
%закрытие системы
save_system(handle);
close_system(handle);
end
