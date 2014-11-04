clear all
clc

% [filename, pathname] = uigetfile('DataFromLMS/*.mat');
% [time,data,Sv,text]=LoadData([pathname,filename]);
% 
% x=Sv:time:150;
% % subplot(2,1,1)
% % plot(x,data(1:length(x),7))
% % subplot(2,1,2)
% % plot(x,data(1:length(x),8))
% 
% temp(1:length(x)/4)=data(1:4:length(x),7);
load data/data_fil
d=1;
temp=y_data(1:d:end)/9.8;
fileID = fopen('C2_2_12-552_full.dat','w');
fprintf(fileID,'%8.5e\n',temp);
fclose(fileID);