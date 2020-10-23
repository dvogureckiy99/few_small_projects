function prints(name,folder,fig,cut)
   %%Prints Print current simulink model screen and save as eps and pdf
   %save to pdf and crop with dos
   
   if strncmpi(name,'sim',3) % simulink model
     print(['-s',name], '-dpdf','-tiff', [folder,name]) 
   else
    %path = join([folder,name]);
    %print([folder,name], '-dpdf','-painters','-r300','-bestfit',gcf);%
    print([folder,name], '-dpdf','-painters','-r300','-bestfit',fig);%
   end
   
   if nargin < 4 % cut
   dos(['pdfcrop ' folder name '.pdf ' folder  name '.pdf']);% & работает в фоновом режиме
   dos('EXIT');
   end
end 
