clear
clc

load MTX_r

fileID = fopen('txt_out\Kr.txt','w');
fprintf(fileID,'%8.5e,%8.5e,%8.5e,%8.5e,\n',Kr);
fclose(fileID);

fileID = fopen('txt_out\Mr.txt','w');
fprintf(fileID,'%8.5e,%8.5e,%8.5e,%8.5e,\n',Mr);
fclose(fileID);