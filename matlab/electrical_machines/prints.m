function prints(name,folder,fig,cut)
   %%Prints Print current simulink model screen and save as eps and pdf
   %save to pdf and crop with dos
   
   if strncmpi(name,'sim_',4) % simulink model
     print(['-s',name], '-dpdf','-tiff', [folder,name]) 
   else
    %path = join([folder,name]);
    if nargin < 3
        print([folder,name], '-djpeg','-painters','-r300',gcf);%
    else
        print([folder,name], '-dmeta','-painters','-r300',fig);%
    end
   end
   
   if nargin < 4 % cut
   dos(['pdfcrop ' folder name '.pdf ' folder  name '.pdf']);% & работает в фоновом режиме
   dos('EXIT');
   end
end 