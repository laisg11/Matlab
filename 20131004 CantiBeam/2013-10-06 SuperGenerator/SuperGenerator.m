
clear all
clc
%% Nodes
load Nodes
[nNodes,DoF]=size(Nodes);

%% Material Peoperty
E=200e3;
v=0.3;
G=0.5*E/(1+v);
%% Nodes

R(nNodes,nNodes)=0;
for i=1:nNodes
    R(i,:)=[1 Nodes(i,1) Nodes(i,2) Nodes(i,3) Nodes(i,1)*Nodes(i,2) ...
        Nodes(i,2)*Nodes(i,3) Nodes(i,1)*Nodes(i,3) ...
        Nodes(i,1)*Nodes(i,2)*Nodes(i,3)];
end
N=inv(R);
ds=2;
K(nNodes*DoF,nNodes*DoF)=0;K2=K;
%% Shape Matrix
factor=E*(1-v)/(1+v)/(1-2*v); factor2=(1-2*v)/2/(1-v);
D=factor*[1        v/(1-v)     v/(1-v)     0      0      0; ...
          v/(1-v)     1        v/(1-v)     0      0      0; ...
          v/(1-v)  v/(1-v)       1         0      0      0; ...
          0           0          0      factor2   0      0; ...
          0           0          0         0   factor2   0; ...
          0           0          0         0      0   factor2;];


for x=0:ds:1000
    for y=-10:ds:10
        for z=0:ds:40
            
dNx=[0 1 0 0 y 0 z y*z];     
dNy=[0 0 1 0 x z 0 x*z];
dNz=[0 0 0 1 0 y x x*y];
E_disX=dNx(1:nNodes)*N;
E_disY=dNy(1:nNodes)*N;
E_disZ=dNz(1:nNodes)*N;

for i=1:8
   B(1:6,(i*3-2):i*3)=[E_disX(i)         0            0; ...
                       0              E_disY(i)       0; ...
                       0                 0          E_disZ(i); ...
                       E_disY(i)      E_disX(i)       0; ...
                       0              E_disZ(i)     E_disY(i); ...
                       E_disZ(i)         0          E_disX(i);]; 
end

dK=B'*D*B*ds^3;
K=K+dK;
        end
    end
end

