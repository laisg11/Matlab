%基于子空间的超级单元法 20节点

clear all
clc
%%%%%%%%%%  用户输入数据 %%%%%%%%

Scale=100;
Load_point=[17, 18];
Load_dir=3;
dt=0.1;
Fixed_point=[1,  2,3, 4];
Free_DOF=[0,0,0];
C_alfa=0.5;%0.1
C_beta=0.12;%0.12

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%  初始化 %%%%%%%%%%%%% 
addpath('lib')
addpath('Data')

load MTX_r
load Load_Ext
Nnodes=20;
Total_Time=Time_Load(end);
%C=C_alfa*Mr+C_beta*Kr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

varin{1}=Nnodes;
varin{2}=Kr;
varin{3}=Mr;
varin{4}=Load_point;
varin{5}=Load_dir;
varin{6}=Load_Ext;
varin{7}=dt;
varin{8}=Total_Time;
varin{9}=Fixed_point;
varin{10}=Free_DOF;
varin{11}=C_alfa;
varin{12}=C_beta;

%%%%%%%%%%  求解过程 %%%%%%%%%%%

[U,V,A]=solver_central(varin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nodes=insert_nodes_data(Nodes,U,V,A);
% plotnodes(Nodes,Scale)
% 
U_out=U(Load_point(2)*3,:);
figure(2)
plot(Time_Load,U_out)
hold on
load Result_From_ABQ
plot(Result_From_ABQ(:,1),Result_From_ABQ(:,2),'r')