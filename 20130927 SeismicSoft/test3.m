clear
clc
% 基底加速度、速度、位移 与 输入数据对比
load DataFromABQ\C5_all

inp=Input;inc=1/800;
inp1(:,1)=inp(:,1);inp2(:,1)=inp(:,1);
inp1(:,2)=cumsum(inp(:,2)*inc);
inp2(:,2)=cumsum(inp1(:,2)*inc);

subplot(3,1,1)
plot(A_btm(:,1),A_btm(:,2),'b')
hold on
plot(A_brk_u(:,1),A_brk_u(:,2),'g')
hold on
plot(A_brk_p(:,1),A_brk_p(:,2),'m')
hold on
plot(inp(:,1),inp(:,2),'r')
legend ('Bottom','Upper-Brick','Lower-Brick','Input')
%legend ('Bottom','Input')
title('A1')

subplot(3,1,2)
plot(V_btm(:,1),V_btm(:,2),'b')
hold on
plot(V_brk_u(:,1),V_brk_u(:,2),'g')
hold on
plot(V_brk_p(:,1),V_brk_p(:,2),'m')
hold on
plot(inp1(:,1),inp1(:,2),'r')
legend ('Bottom','Upper-Brick','Lower-Brick','Input')
title('V1')

subplot(3,1,3)
plot(U_btm(:,1),U_btm(:,2),'b')
hold on
plot(U_brk_u(:,1),U_brk_u(:,2),'g')
hold on
plot(U_brk_p(:,1),U_brk_p(:,2),'m')
hold on
plot(inp2(:,1),inp2(:,2),'r')
legend ('Bottom','Upper-Brick','Lower-Brick','Input')
title('U1')