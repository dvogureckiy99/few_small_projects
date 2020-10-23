function system_variable_structure1(PATH)
name_system = 'sim_variable_structure2';                 %имя схемы

%имя и путь рисунка схемы для Latex
% картинка схемы
% figure_name = name_system;
% figure_file_path=['images/',figure_name];%
% figure_file_path = join(figure_file_path);
% Cellfig_names{1} = figure_name ;
% Cellfig_path{1}=figure_file_path;
% Cellfig_description{1}=' Стурктурная схема системы с переменной структурой.';

%имя и путь графика для Latex
% фазовые траектории
figure_name = strrep(name_system,'sim_','');%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
Cellfig_names{2} = figure_name ;
Cellfig_path{2}=figure_file_path;
Cellfig_description{2}=' Фазовые траектории для системы с переменной структурой с разными начальными условиями.';
% 
% Переменные состояния
figure_name = [strrep(name_system,'sim_',''),'_sys'];%имя графика
figure_file_path=['images/',figure_name];% путь к графику
figure_file_path = join(figure_file_path);
Cellfig_names{3} = figure_name ;
Cellfig_path{3}=figure_file_path;
Cellfig_description{3}=' Графики изменения переменных состояния.';

handle = load_system(name_system); %загрузка схемы

% Сохранение рисунка схемы
% prints(name_system,PATH.images); %save to pdf and crop with dos

%установка параметров
b = 1.6;
c =20;
K0=40;
T1=0.3;
T2=2;
T3=0.1;
ro=1.5;
FStep=10^-4;
Cellfig{2} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
Cellfig{3} = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1],'PaperOrientation','Landscape');
for k=0:2
   x0=10*k;
   y0=0;
    
%перенос переменных в основную базу переменных
assignin('base','end_time',10);%------------------------------------------------------------------время симуляции
assignin('base','b',b);
assignin('base','c',c);
assignin('base','T1',T1);
assignin('base','T2',T2);
assignin('base','T3',T3);
assignin('base','x0',x0);
assignin('base','y0',y0);
assignin('base','ro',ro);
assignin('base','K0',K0);
assignin('base','FStep',FStep);

set_param(handle,'StopTime','end_time' ,'SolverPrmCheckMsg','warning'...
    ,'SolverResetMethod','robust','Solver','ode113','SolverType','Fixed-step','FixedStep','FStep',...
    'SaveFormat','Array','SaveOutput','off','ReturnWorkspaceOutputs','off')

%возвращает сигналы в массиве b в п7орядке согласно номерам портов
[t,~,x,y] = sim(name_system);
assignin('base','x',x);
assignin('base','y',y);
 
figure(Cellfig{2});%target figure
plot(x,y,'black-','LineWidth',1);grid on, hold on
xlabel('x'),ylabel('y(x)=dx/dt')
% legend( ['ПХ по скорости с нелинейным элементом' ]...
%     'Location','southoutside','Box','off' ) 
plot(x(1),y(1),'kx','MarkerFaceColor','k','MarkerSize',10);grid on, hold on

% p(1).LineWidth = 2;
%graph_variable_structure1(x,y,t,PATH,figure_name);%строит график

figure(Cellfig{3});%target figure
subplot(1,2,1);
plot(t,y,'black-');grid on,hold on ;
xlabel('t'),ylabel('y(x)=dx/dt')
subplot(1,2,2);
plot(t,x,'black-');grid on,hold on ;
xlabel('t'),ylabel('x')
% for a=2:3
%    p(a).LineWidth = 2;
% end
    
end
prints(Cellfig_names{2},PATH.images,Cellfig{2}); %save to pdf and crop with dos
prints(Cellfig_names{3},PATH.images,Cellfig{3}); %save to pdf and crop with dos
close(Cellfig{2}); %закрываем , чтобы не засорять память
close(Cellfig{3}); %закрываем , чтобы не засорять память
%% 
%закрытие системы
save_system(handle);
% close_system(handle);

% FIGS.description = Cellfig_description;
% FIGS.names=Cellfig_names;
% FIGS.path=Cellfig_path;
end
