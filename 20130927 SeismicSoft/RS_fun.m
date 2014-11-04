clear  
clc
% ***********读入地震记录*********** 
%fid = fopen('CHI010.txt');  
%[Accelerate,count] = fscanf(fid,'%g'); %count 读入的记录的量 

addpath('Data')
load data_fil
Accelerate=y_data;
count=length(y_data);
Accelerate=9.8*Accelerate';             %单位统一为 m和s 
time=0:0.005:(count-1)*0.005;           %单位 s 
% ***********精确法计算各反应*********** %初始化各储存向量  
Displace=zeros(1,count);    %相对位移 
Velocity=zeros(1,count);    %相对速度 
AbsAcce=zeros(1,count);     %绝对加速度 
% ***********A,B矩阵*********** 
DampA=[0,0.05,0.1];     %三个阻尼比  
TA=0.1:0.5:6;      
%TA=0.000001:0.02:6;     %结构周期
Dt=0.00125;               %地震记录的步长  
%记录计算得到的反应，MDis为某阻尼时最大相对位移，MVel为某阻尼 %时最大相对速度，MAcc某阻尼时最大绝对加速度，用于画图 
MDis=zeros(3,length(TA)); MVel=zeros(3,length(TA)); 
MAcc=zeros(3,length(TA));  
j=1;    %在下一个循环中控制不同的阻尼比 
for Damp=[0.1,0.15,0.2]          
    t=1;    %在下一个循环中控制不同的结构自振周期     
    for T=0.1:0.5:6          
        Frcy=2*pi/T;  %结构自振频率                  
        DamFrcy=Frcy*sqrt(1-Damp*Damp);   %计算公式化简         
        e_t=exp(-Damp*Frcy*Dt);        
        s=sin(DamFrcy*Dt);         
        c=cos(DamFrcy*Dt);                  
        A=zeros(2,2);            
        A(1,1)=e_t*(s*Damp/sqrt(1-Damp*Damp)+c);           
        A(1,2)=e_t*s/DamFrcy;            
        A(2,1)=-Frcy*e_t*s/sqrt(1-Damp*Damp);             
        A(2,2)=e_t*(-s*Damp/sqrt(1-Damp*Damp)+c);                    
        d_f=(2*Damp^2-1)/(Frcy^2*Dt); %计算公式化简        
        d_3t=Damp/(Frcy^3*Dt);                          
        B=zeros(2,2);             
        B(1,1)=e_t*((d_f+Damp/Frcy)*s/DamFrcy+(2*d_3t+1/Frcy^2)*c)-2*d_3t;             
        B(1,2)=-e_t*(d_f*s/DamFrcy+2*d_3t*c)-1/Frcy^2+2*d_3t;             
        B(2,1)=e_t*((d_f+Damp/Frcy)*(c-Damp/sqrt(1-Damp^2)*s)-(2*d_3t+1/Frcy^2)*(DamFrcy*s+Damp*Frcy*c))+1/(Frcy^2*Dt);              B(2,2)=e_t*(1/(Frcy^2*Dt)*c+s*Damp/(Frcy*DamFrcy*Dt))-1/(Frcy^2*Dt); 
        for i=1:(count-1)    %根据地震记录,计算不同的反应            
            Displace(i+1)=A(1,1)*Displace(i)+A(1,2)*Velocity(i)+B(1,1)*Accelerate(i)+B(1,2)*Accelerate(i+1);            
            Velocity(i+1)=A(2,1)*Displace(i)+A(2,2)*Velocity(i)+B(2,1)*Accelerate(i)+B(2,2)*Accelerate(i+1);            
            AbsAcce(i+1)=-2*Damp*Frcy*Velocity(i+1)-Frcy^2*Displace(i+1);         
        end
        MDis(j,t)=max(abs(Displace));        
        MVel(j,t)=max(abs(Velocity));        
        if T==0.0             
            MAcc(j,t)=max(abs(Accelerate));       
        else
            MAcc(j,t)=max(abs(AbsAcce));        
        end
        Displace=zeros(1,count);%初始化各储存向量，避免下次不同周期计算时引用到前一个周期的结果         
        Velocity=zeros(1,count);        
        AbsAcce=zeros(1,count);                 
        t=t+1;     
    end
    j=j+1; 
end  % ***********PLOT*********** close all  figure %绘制地震记录图 
plot(time(:),Accelerate(:))     
title('PEER STRONG MOTION DATABASE RECORD--CHI010') 
xlabel('time(s)')  
ylabel('acceleration(g)') 
grid  
figure %绘制位移反应谱   
plot(TA,MDis(1,:),'-.b',TA,MDis(2,:),'-r',TA,MDis(3,:),':k') 
title('Displacement') 
xlabel('Tn(s)') 
ylabel('Displacement(m)')  
legend('ζ=0','ζ=0.05','ζ=0.1')
grid 
figure %绘制速度反应谱   
plot(TA,MVel(1,:),'-.b',TA,MVel(2,:),'-r',TA,MVel(3,:),':k') 
title('Velocity') 
xlabel('Tn(s)')  
ylabel('velocity(m/s)')  
legend('ζ=0','ζ=0.05','ζ=0.1') 
grid  
figure %绘制绝对加速度反应谱   
plot(TA,MAcc(1,:),'-.b',TA,MAcc(2,:),'-r',TA,MAcc(3,:),':k') 
title('Absolute Acceleration') 
xlabel('Tn(s)')  
ylabel('absolute acceleration(m/s^2)') 
legend('ζ=0','ζ=0.05','ζ=0.1') 
grid  figure %绘制标准加速度反应谱   
M=max(abs(Accelerate)); %地震记录最大值  
plot(TA,MAcc(1,:)/M,'-.b',TA,MAcc(2,:)/M,'-r',TA,MAcc(3,:)/M,':k') 
title('Normalized Absolute Acceleration') 
xlabel('Tn(s)')  
ylabel('Normalized absolute acceleration') 
legend('ζ=0','ζ=0.05','ζ=0.1') 
grid  
%%%%%%%%%%%%%%%%%%%%% End With  matlab6.5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%