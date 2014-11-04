clear all
clc

[time,data,text]=LoadData('DataFromLMS/C1_1');
plot(time,data(1:end,1))