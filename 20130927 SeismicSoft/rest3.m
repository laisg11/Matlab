clear
clc
% 基底加速度、速度、位移 与 输入数据对比
load debug\debug
inc=1/800;
inp1=inp;inp2=inp;
inp1(:,2)=cumsum(inp(:,2)*inc);
inp2(:,2)=cumsum(inp1(:,2)*inc);

subplot(3,1,1)
plot(inp(:,1),inp(:,2))
hold on
plot(re(:,1),re(:,2),'r')
legend('Inp','Res')

subplot(3,1,2)
plot(inp1(:,1),inp1(:,2))
hold on
plot(re1(:,1),re1(:,2),'r')
legend('Inp-v','Res-v')

subplot(3,1,3)
plot(inp2(:,1),inp2(:,2))
hold on
plot(re2(:,1),re2(:,2),'r')
legend('Inp-s','Res-s')