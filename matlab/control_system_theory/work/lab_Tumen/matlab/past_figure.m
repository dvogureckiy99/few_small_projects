function past_figure(PATH,section_name,name_subsection,FIGS)
%вставка необходимых рисунков
disp('обработка past figure');
%% Создание файлов
path_subsection = [PATH.Texcomponents,section_name,'\'];%путь к subsection files
file_path=[path_subsection ,name_subsection,'.tex'];
file_path = join(file_path);
fid = fopen(file_path,'w','l','UTF-8');
%% вставка всех картинок
count_figs=length(FIGS.names);
    for i=1:count_figs
        figure_name=FIGS.names{i};
        figure_path=FIGS.path{i};
        description=FIGS.description{i};
        tex_past_figure(fid,figure_path,figure_name,description,0.7);
    end
fclose(fid); % необходимо для обработки файла , удаление и т.д.
end
