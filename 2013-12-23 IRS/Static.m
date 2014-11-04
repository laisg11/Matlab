%基于子空间的超级单元法
clear all
clc
addpath('lib')
addpath('Data')
%入口数据
load Data
Nodes=[1,5,45,41,901,905,945,941];
scale=1;
Omiga=5;

%处理过程
[Kr,Mr]=MatrixTransform(M_Fine,K_Fine,Nodes,Omiga);
%出口数据

%load Reducted
K=Kr;

%处理边界条件 1~4节点固定 置一法
for i=1:12
    K(i,:)=0;
    K(:,i)=0;
    K(i,i)=1;
end
% 力边界条件
P(24)=0;
P(4*3+3)=-10000;
P(5*3+3)=-10000;
U=P*inv(K);

% 后处理
a=20/2;h=40;b=100;
temp=[ 0   -a   h;...
       0    a   h;...
       0    a   0;...
       0   -a   0;...
       b   -a   h;...
       b    a   h;...
       b    a   0;...
       b   -a   0;];
% for i=1:8
%     Nodes(i).loc=temp(i,:);
%     Nodes(i).dis=U(i*3-2:i*3);
% end
% for i=1:8
%     Nodes(i+8).loc=temp(i,:)+[0,0,100];
%     Nodes(i+8).dis=U(i*3-2+24:i*3+24);
% end
PostPlot(temp,U,scale)