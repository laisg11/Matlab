clear
clc
% 基底加速度、速度、位移 与 输入数据对比
load DataFromABQ\C5_all

inp=Input;inc=1/800;
inp1(:,1)=inp(:,1);inp2(:,1)=inp(:,1);
inp1(:,2)=cumsum(inp(:,2)*inc);
inp2(:,2)=cumsum(inp1(:,2)*inc);
%%
% figure(1)
% subplot(3,1,1)
% plot(inp(:,1),inp(:,2),'r')
% hold on
% plot(A_P1_X(:,1),A_P1_X(:,2),'b')
% hold on
% plot(A_brk_u(:,1),A_brk_u(:,2),'g')
% hold on
% plot(A_brk_p(:,1),A_brk_p(:,2),'m')
% legend('Input','P1-X','Upper-Brick','Lower-Brick')
% title('A1')
% xlabel('Time /s')
% ylabel('Acc mm/s^2')
% 
% subplot(3,1,2)
% plot(inp(:,1),inp(:,2),'r')
% hold on
% plot(A_P1_X(:,1),A_P1_X(:,2),'b')
% legend('Input','P1-X')
% title('A1')
% xlabel('Time /s')
% ylabel('Acc mm/s^2')
% 
% subplot(3,1,3)
% plot(A_P1_X(:,1),A_P1_X(:,2),'b')
% hold on
% plot(A_brk_u(:,1),A_brk_u(:,2),'g')
% hold on
% plot(A_brk_p(:,1),A_brk_p(:,2),'m')
% legend('P1-X','Upper-Brick','Lower-Brick')
% title('A1')
% xlabel('Time /s')
% ylabel('Acc mm/s^2')
% %%
% figure(2)
% subplot(3,1,1)
% plot(inp2(:,1),inp2(:,2),'r')
% hold on
% plot(U_P1_X(:,1),U_P1_X(:,2),'b')
% hold on
% plot(U_P7(:,1),U_P7(:,2),'g')
% hold on
% plot(U_P8(:,1),U_P8(:,2),'m')
% hold on
% plot(U_brk_u(:,1),U_brk_u(:,2),'y')
% hold on
% plot(U_brk_p(:,1),U_brk_p(:,2),'k')
% legend('Input','P1-X','P7','P8','Upper-Brick','Lower-Brick')
% title('U1')
% xlabel('Time /s')
% ylabel('Disp mm')
% 
% subplot(3,1,2)
% plot(U_P1_X(:,1),U_P1_X(:,2),'b')
% hold on
% plot(U_P7(:,1),U_P7(:,2),'g')
% hold on
% plot(U_P8(:,1),U_P8(:,2),'m')
% legend('P1-X','P7','P8')
% title('U1')
% xlabel('Time /s')
% ylabel('Disp mm')
% 
% subplot(3,1,3)
% plot(U_P7(:,1),U_P7(:,2),'g')
% hold on
% plot(U_P8(:,1),U_P8(:,2),'m')
% hold on
% plot(U_brk_u(:,1),U_brk_u(:,2),'y')
% hold on
% plot(U_brk_p(:,1),U_brk_p(:,2),'k')
% 
% legend('P7','P8','Upper-Brick','Lower-Brick')
% title('U1')
% xlabel('Time /s')
% ylabel('Disp mm')

% U_P8=U_P8/9*10;
% U_P7=U_P7/9*10;
figure(3)

subplot(2,1,1)
plot(U_P8(:,1),U_P8(:,2),'r','linewidth',2)
hold on
plot(U_brk_u(:,1),U_brk_u(:,2),'g--','linewidth',2)
legend('Detectiv Point 8','Upper-Brick')
title('U1 at Upper-Brick')
xlabel('Time /s')
ylabel('Disp mm')

subplot(2,1,2)
plot(U_P7(:,1),U_P7(:,2),'b','linewidth',2)
hold on
plot(U_brk_p(:,1),U_brk_p(:,2),'g--','linewidth',2)

legend('Detectiv Point 7','Lower-Brick')
title('U1 at Lower-Brick')
xlabel('Time /s')
ylabel('Disp mm')