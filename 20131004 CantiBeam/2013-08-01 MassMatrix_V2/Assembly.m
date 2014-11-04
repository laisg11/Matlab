%组装刚度阵
clear all
clc
% 载入刚度阵
addpath('lib')
importfile('Stiffness Matrix.dat')
SM=reshape(StiffnessMatrix',24,24);
Spring_K(1)=100;
Spring_K(2)=100;
Spring_K(3)=100;
scale=1;

Elements(1).SM=SM;Elements(1).rot=0;
Elements(2).SM=SM;Elements(2).rot=0;

K=K_Assembly(Elements,Spring_K);

%处理边界条件 5~8节点固定 置一法
for i=1:12
    K(i+12,:)=0;
    K(:,i+12)=0;
    K(i+12,i+12)=1;
end
% 力边界条件
P(48)=0;
P(24+2)=1000;
P(24+3)=1000;
U=P/K;

% 后处理
S12=157.1;
S34=104.6;
d=249.7;
h=100;

temp=[0   -S12/2   h;...
       0    S12/2   h;...
       d    S34/2   h;...
       d   -S34/2   h;...
       0   -S12/2   0;...
       0    S12/2   0;...
       d    S34/2   0;...
       d   -S34/2   0;];
% for i=1:8
%     Nodes(i).loc=temp(i,:);
%     Nodes(i).dis=U(i*3-2:i*3);
% end
% for i=1:8
%     Nodes(i+8).loc=temp(i,:)+[0,0,100];
%     Nodes(i+8).dis=U(i*3-2+24:i*3+24);
% end
PostPlot(temp,U,scale)

