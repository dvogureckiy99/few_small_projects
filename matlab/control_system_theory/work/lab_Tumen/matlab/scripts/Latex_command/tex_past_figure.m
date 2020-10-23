function tex_past_figure(fid,figure_file_path,figure_name,description,width)
%Past image in tex document
    fprintf(fid,'%s\r','\begin{figure}[!h]\centering');
    fprintf(fid,'%s','\includegraphics[width=');
    fprintf(fid,'%.1f',width);
    fprintf(fid,'%s','\linewidth]{');
    fprintf(fid,'%s}\r',figure_file_path);
    fprintf(fid,'%s\r',['\caption{',description,'}\label{fig:',figure_name,'}']);
    fprintf(fid,'%s\r','\end{figure}');
end
