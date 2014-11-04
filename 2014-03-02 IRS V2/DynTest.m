% 动态问题求解 Newmark
% 初始化参数
clear all
clc
disp('NEWMARK-β  动态模拟')
addpath('Data')
addpath('lib')
load ElCentro  % mm/s/s
load Reducted  % 载入 Kr Mr

% 配置参数
Nnode=8;            %节点数
DoN=3;              %节点自由度
ElCentro_dt=0.02;   %载荷时间增量
PLoad=[6,5];        %加载结点编号
PDof=3;             %加载方向
scale=9800;            %加载放大系数
dt=0.02;gama=0.5;beta=1/4;

%1 初始化计算
U(Nnode*DoN,1)=0;    %初始化位移
U1(Nnode*DoN,1)=0;   %初始化速度
U2(Nnode*DoN,1)=0;   %初始化加速度

ElCentro=ElCentro*scale;

a(8)=1/beta/dt/dt;
a(1)=gama/beta/dt;
a(2)=1/beta/dt;
a(3)=1/2/beta-1;
a(4)=gama/beta-1;
a(5)=dt/2*(gama/beta-2);
a(6)=dt*(1-gama);
a(7)=gama*dt;

K=Kr;M=Mr;
C=10000*K+150*M;

%2 形成等效刚度阵
Ke=K+a(8)*M+a(1)*C;
%3 计算下一时刻的等效载荷
Ua(1:Nnode*DoN)=0;
Ub(1:Nnode*DoN)=0;
P(1:Nnode*DoN)=0;
for i=0:dt:30-2*dt
    t=i/dt+1;    
%    Ua(PLoad(1)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);
%    Ua(PLoad(2)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);
    
%    Ub(PLoad(1)*3-3+PDof)=U2(PLoad(1)*3-3+PDof,round(t));
%    Ub(PLoad(2)*3-3+PDof)=U2(PLoad(2)*3-3+PDof,round(t));

%    P=M*(Ua-Ub)';
    P(PLoad(1)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);   
    P(PLoad(2)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1); 

    Pe=P'+M*(a(8)*U(:,round(t))+a(2)*U1(:,round(t))+a(3)*U2(:,round(t)))+C*(a(1)*U(:,round(t))+a(4)*U1(:,round(t))+a(5)*U2(:,round(t)));
    %4 计算下一时刻位移速度加速度
    U(:,round(t+1))=Ke\Pe;
    U2(:,round(t+1))=a(8)*(U(:,round(t+1))-U(:,round(t)))-a(2)*U1(:,round(t))-a(3)*U2(:,round(t));
    U1(:,round(t+1))=U1(:,round(t))+a(6)*U2(:,round(t))+a(7)*U2(:,round(t+1));
end

Xdata=0:dt:30-dt;
Ydata=U(21,:);
plot(Xdata,Ydata)





