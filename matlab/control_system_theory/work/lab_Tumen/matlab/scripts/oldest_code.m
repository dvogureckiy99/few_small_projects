function create_section(InitialConditions,PATH,section_name)
%создаёт папки в папке components, содержащие разделы главы, и заполняет её
%необходимыми компонентами
% section_name ? имя главного Tex file chapter
% PATH ? структура с путями
% InitialConditions ? начальные условия
%Для записи простого текста, который не будет изменяться использовать файлы
%заглушки, создаваемые функцией make_hole. Естественно, что текст заглушек
%будет следовать в порядке , в которром вы создавали заглушки в
% "Создание имен файлов и заглушек", поэтому порядок их размещения важен
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%Необходимо обязательно имя заглушки начинать с "hole_"
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
section_title = 'Принципы построения систем с переменной структурой' ;
disp(['Обработка --- Chapter_name:"',section_name,'"']);
%% формирование пути к папке с chapter (или section)
path_subsection = [PATH.Texcomponents,section_name,'\']; %путь к папке главы(chapter),
% в которой будут храниться главы(section)или подглавы(subsection,если
% создаётся лабораторная или курсач)
%% Создание папки, содержащей главу
[status,msg]=mkdir(path_subsection)
%% Создание имен файлов и заглушек
Cellname_subsection{1} =  'find_PD'; %имя файла для find_PD
Cellname_subsection{2} =  'hole_find_PD'; %файл заключения (далее просто "текст")
%% формирование пути к  файлу с описанием разделов(section) главы( chapter) или подразделов разделов.
file_path=[path_subsection ,section_name,'.tex'];        %путь к файлу с описанием разделов(section) главы( chapter)
file_path = join(file_path);
fid = fopen(file_path,'w','l','UTF-8');                  
%% Заполнение главного Tex file
fprintf(fid,'%s\r',['\section{',section_title,'}']);    %запись имени новой секции
for i=1:length(Cellname_subsection)
    fprintf(fid,'%s\r',['\input{components/',section_name,'/',Cellname_subsection{i},'}']); %прописываем пути ко всем файлам
end
fclose all; % необходимо для обработки файла , удаление и т.д.

%% Непосредственное создание tex files
for i=1:length(Cellname_subsection)
    name_subsection = Cellname_subsection{i} ; %извлекаем имя из ячейки
    if strncmpi(name_subsection,'hole_',5) %нужно создать файл заглушку
        description = ['Hole number:', num2str(i)];
        make_hole(path_subsection,name_subsection,description); %создаём файл-заглушку для заключения
    else
        %просто создаём нужные файлы (основные функции работы с матлаб)
        %find_PD(InitialConditions,PATH,section_name,name_subsection);    %находит коэффициенты для системы с фазовой траекторие типа "седло" .
    
    end
end

