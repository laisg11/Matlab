% 动态问题求解 Newmark
% 初始化参数
clear all
clc
disp('NEWMARK-β  动态模拟')
disp('El Centro  Total Time : 30s')
addpath('input_data')
addpath('lib')
load ElmKM
load ElCentro

Spring_K(1)=100;
Spring_K(2)=100;
Spring_K(3)=1000;
scale=1;
dt=0.02;gama=0.5;beta=1/4;
ElCentro=ElCentro*9800;
% ElCentro(2:3001)=ElCentro;
% ElCentro(1)=0;

U(48,1)=0;
U1(48,1)=0;
U2(48,1)=0;

%1 初始化计算
ElCentro_dt=0.02;
a(8)=1/beta/dt/dt;
a(1)=gama/beta/dt;
a(2)=1/beta/dt;
a(3)=1/2/beta-1;
a(4)=gama/beta-1;
a(5)=dt/2*(gama/beta-2);
a(6)=dt*(1-gama);
a(7)=gama*dt;

%2 构成刚度阵,质量阵和阻尼阵
Elements(1).K=K;Elements(1).rot=0;
Elements(2).K=K;Elements(2).rot=0;

K=K_Assembly(Elements,Spring_K);
temp(1:24,1:24)=M;temp(25:48,25:48)=M;M=temp*1;
C=0.5*K+0.5*M;
%3 形成等效刚度阵
Ke=K+a(8)*M+a(1)*C;
%4 计算下一时刻的等效载荷
Ua(1:48)=0;
Ub(1:48)=0;
for i=0:dt:30-2*dt
    t=i/dt+1;    
    Ua(4*3+2)=ElCentro(round(i/ElCentro_dt)+1);
    Ua(5*3+2)=ElCentro(round(i/ElCentro_dt)+1);
    Ua(6*3+2)=ElCentro(round(i/ElCentro_dt)+1);
    Ua(7*3+2)=ElCentro(round(i/ElCentro_dt)+1);
    
    Ub(4*3+2)=U2(4*3+2,round(t));
    Ub(5*3+2)=U2(5*3+2,round(t));
    Ub(6*3+2)=U2(6*3+2,round(t));
    Ub(7*3+2)=U2(7*3+2,round(t));
    P=M*(Ua-Ub)';
    Pe=P+M*(a(8)*U(:,round(t))+a(2)*U1(:,round(t))+a(3)*U2(:,round(t)))+C*(a(1)*U(:,round(t))+a(4)*U1(:,round(t))+a(5)*U2(:,round(t)));
    %5 计算下一时刻位移速度加速度
    U(:,round(t+1))=Ke\Pe;
    U2(:,round(t+1))=a(8)*(U(:,round(t+1))-U(:,round(t)))-a(2)*U1(:,round(t))-a(3)*U2(:,round(t));
    U1(:,round(t+1))=U1(:,round(t))+a(6)*U2(:,round(t))+a(7)*U2(:,round(t+1));
end
temp=U(24+2*3+2,:)';
temp(:,2)=ElCentro(1:30/0.02);

for i=1:length(temp(:,2))
    EU1(i)=sum(temp(1:i,2)*0.02);
end
for i=1:length(EU1)
    EU(i)=sum(EU1(1:i)*0.02);
end

subplot(2,1,1)
plot(0:0.02:length(temp(:,1))*0.02-0.02,temp(:,1))
hold on
EU(5:end)=EU(1:end-4);
plot(0:0.02:length(temp(:,1))*0.02-0.02,-EU,'--r')

xlabel('Time / s')
ylabel('Motion / mm')
title('Motion')
legend('Ref Point','El Centro')

subplot(2,1,2)
plot(0:0.02:length(temp(:,1))*0.02-0.02,U2(24+2*3+2,:))
hold on
plot(0:0.02:length(temp(:,1))*0.02-0.02,temp(:,2),'--r')
xlabel('Time / s')
ylabel('Acc / mm/s^2')
title('Acc')
axis([0 length(temp(:,1))*0.02-0.02 -5000 5000])
legend('Ref Point','El Centro')




