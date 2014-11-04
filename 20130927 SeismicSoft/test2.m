clear all
clc

[time,data,Sv,text]=LoadData('DataFromLMS/C1_3.mat');
order=4;
Wn=[0.1,25]/400;
[b,a]=butter(order,Wn,'bandpass');
h1=dfilt.df2(b,a);      
fvtool(h1,'FrequencyScale','log')
%plot(f2)