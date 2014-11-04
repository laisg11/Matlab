function [U_out,V_out,A_out]=solver_central(varin)

Nnodes=varin{1};
K_Fine=varin{2};
M_Fine=varin{3};
Load_point=varin{4};
Load_dir=varin{5};
Load_Ext=varin{6};
dt=varin{7};
Total_Time=varin{8};
Fixed_point=varin{9};
Free_DOF=varin{10};
C_alfa=varin{11};
C_beta=varin{12};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[a,b]=size(K_Fine);
[c,d]=size(M_Fine);
if dt>=5/pi
    warning('时间步长太长，可能不收敛');
end
if a~=b || c~=d || a~=c
    error('K & M 矩阵维度有问题');
end
if a~=Nnodes*3
    error('节点数和刚度阵不匹配');
end
Step=length(Load_Ext)+1;
U(1:Nnodes*3,Step)=0;
V(1:Nnodes*3,Step)=0;
A(1:Nnodes*3,Step)=0;

for i=1:length(Fixed_point)
    K_Fine(Fixed_point(i)*3-2,:)=K_Fine(Fixed_point(i)*3-2,:)*Free_DOF(1);
    K_Fine(Fixed_point(i)*3-1,:)=K_Fine(Fixed_point(i)*3-1,:)*Free_DOF(2);
    K_Fine(Fixed_point(i)*3,:)=K_Fine(Fixed_point(i)*3,:)*Free_DOF(3);
    
    K_Fine(:,Fixed_point(i)*3-2)=K_Fine(:,Fixed_point(i)*3-2)*Free_DOF(1);
    K_Fine(:,Fixed_point(i)*3-1)=K_Fine(:,Fixed_point(i)*3-1)*Free_DOF(2);
    K_Fine(:,Fixed_point(i)*3)=K_Fine(:,Fixed_point(i)*3)*Free_DOF(3);
    
    if Free_DOF(1)==0
        K_Fine(Fixed_point(i)*3-2,Fixed_point(i)*3-2)=1;
    end
    if Free_DOF(2)==0
        K_Fine(Fixed_point(i)*3-1,Fixed_point(i)*3-1)=1;
    end
    if Free_DOF(3)==0
        K_Fine(Fixed_point(i)*3,Fixed_point(i)*3)=1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Force=Load_Ext/length(Load_point);
Time=dt:dt:Total_Time;
Step=length(Time)+1;
P(1:a,Step)=0;
for i=1:Step-1
    P(Load_point*3-3+Load_dir,i+1)=Force(i);
end
C=C_alfa*M_Fine+C_beta*K_Fine;
%C(a,b)=0;

A(:,2)=M_Fine\(P(:,2)-C*V(:,2)-K_Fine*U(:,2));
U(:,1)=U(:,2)-dt*V(:,2)+dt*dt/2*A(:,2);
K=M_Fine/dt/dt+C/2/dt;
a=K_Fine-2*M_Fine/dt/dt;
b=M_Fine/dt/dt-C/2/dt;

for i=3:Step
 P1=P(:,i-1)-a*U(:,i-1)-b*U(:,i-1);
% U(:,i)=pcg(K,P1,1e-2,10000);
 U(:,i)=K\P1;
 V(:,i-1)=(U(:,i)+U(:,i-2))/2/dt;
 A(:,i-1)=(U(:,i)-2*U(:,i-1)+U(:,i-2))/dt/dt;
end

U_out=U(:,2:end);
V_out=V(:,2:end);
A_out=A(:,2:end);
end