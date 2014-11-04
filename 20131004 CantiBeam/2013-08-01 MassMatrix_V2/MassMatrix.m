%组装刚度阵
clear all
clc
addpath('lib')
% 载入刚度阵和质量阵
% importfile('Stiffness Matrix.dat');
% SM=reshape(StiffnessMatrix',24,24);
% importfile('Mass Matrix.dat');
% MM=reshape(MassMatrix',24,24);

%[SM,MM]=CalSMandMM(ds,E,v,dsy)
%[K,M]=CalSMandMM(1,200e3,0.3,7.9e-9);
[K,M]=GerKM(0.5,200e3,0.3,7.9e-9);
save ElmKM


fileID = fopen('mat_f\SM.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',K);
fclose(fileID);

fileID = fopen('mat_f\MM.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',M);
fclose(fileID);
msgbox('Done')

