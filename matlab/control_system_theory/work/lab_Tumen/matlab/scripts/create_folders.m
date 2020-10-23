function [PATH,report_path] = create_folders(root_folder)
report_path =        [root_folder,'report.tex'] ;%путь к основному файлу компиляции отчета
PATH.images        = [root_folder,'images\']    ; %папка с картинками
PATH.Texcomponents = [root_folder,'components\'] ; %папка с кодом для Latex
%PATH.Simulinkmodel =
%% Создание папок
[status,msg]= mkdir(PATH.images);
[status,msg]= mkdir(PATH.Texcomponents);
end
