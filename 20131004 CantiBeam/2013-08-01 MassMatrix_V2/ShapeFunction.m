% 石墨砖八节点单元参数求解
clear all
clc
%% Geometry
S12=20;
S34=20;
d=1000;%249.7
h=40;
%% Material Peoperty
E=200e3;
v=0.3;
G=0.5*E/(1+v);
%% Nodes
Nodes=[0   -S12/2   h;...
       0    S12/2   h;...
       d    S34/2   h;...
       d   -S34/2   h;...
       0   -S12/2   0;...
       0    S12/2   0;...
       d    S34/2   0;...
       d   -S34/2   0;];
R(8,8)=0;
for i=1:8
    R(i,:)=[1 Nodes(i,1) Nodes(i,2) Nodes(i,3) Nodes(i,1)*Nodes(i,2) ...
        Nodes(i,2)*Nodes(i,3) Nodes(i,1)*Nodes(i,3) ...
        Nodes(i,1)*Nodes(i,2)*Nodes(i,3)];
end
N=inv(R);
ds=5;
K(24,24)=0;K2=K;
%% Shape Matrix

x=1;y=1;z=1;
for x=0:ds:1000
    for y=-10:ds:10
        for z=0:ds:40
E_disX=[0 1 0 0 y 0 z y*z]*N;
E_disY=[0 0 1 0 x z 0 x*z]*N;
E_disZ=[0 0 0 1 0 y x x*y]*N;

for i=1:8
   B(1:6,(i*3-2):i*3)=[E_disX(i)         0            0; ...
                       0              E_disY(i)       0; ...
                       0                 0          E_disZ(i); ...
                       E_disY(i)      E_disX(i)       0; ...
                       0              E_disZ(i)     E_disY(i); ...
                       E_disZ(i)         0          E_disX(i);]; 
end
factor=E*(1-v)/(1+v)/(1-2*v); factor2=(1-2*v)/2/(1-v);
D=factor*[1        v/(1-v)     v/(1-v)     0      0      0; ...
          v/(1-v)     1        v/(1-v)     0      0      0; ...
          v/(1-v)  v/(1-v)       1         0      0      0; ...
          0           0          0      factor2   0      0; ...
          0           0          0         0   factor2   0; ...
          0           0          0         0      0   factor2;];
dK=B'*D*B*ds^3;
K=K+dK;
        end
    end
end

fileID = fopen('mat_f\SM.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',K);
fclose(fileID);
