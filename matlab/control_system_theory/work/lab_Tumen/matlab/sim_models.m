root_folder = 'C:\Git\repositories\few_small_projects\matlab\control_system_theory\work\lab_Tumen\matlab'; % путь к корневой папки, куда
% будет записываться вся информация
%% Создание необходимых папок в корневом каталоге
[PATH,report_path] = create_folders(root_folder); 
%% system
system_variable_structure1(PATH);  
% FIGS = system_variable_structure2(InitialConditions,PATH,FIGS); 

