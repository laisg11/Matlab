%ть╨и
clear
clc
x=0.1:0.1:5;
y=1000*sin(x)+500*cos(10*x)+250*sin(20*x);
T(:,1)=x;
T(:,2)=y;
Load_Ext=y;Time_Load=x;
figure(10)
plot(x,y)
save data/Load_Ext Time_Load Load_Ext
