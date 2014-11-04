clear  
clc
% ***********��������¼*********** 
%fid = fopen('CHI010.txt');  
%[Accelerate,count] = fscanf(fid,'%g'); %count ����ļ�¼���� 

addpath('Data')
load data_fil
Accelerate=y_data;
count=length(y_data);
Accelerate=9.8*Accelerate';             %��λͳһΪ m��s 
time=0:0.005:(count-1)*0.005;           %��λ s 
% ***********��ȷ���������Ӧ*********** %��ʼ������������  
Displace=zeros(1,count);    %���λ�� 
Velocity=zeros(1,count);    %����ٶ� 
AbsAcce=zeros(1,count);     %���Լ��ٶ� 
% ***********A,B����*********** 
DampA=[0,0.05,0.1];     %���������  
TA=0.1:0.5:6;      
%TA=0.000001:0.02:6;     %�ṹ����
Dt=0.00125;               %�����¼�Ĳ���  
%��¼����õ��ķ�Ӧ��MDisΪĳ����ʱ������λ�ƣ�MVelΪĳ���� %ʱ�������ٶȣ�MAccĳ����ʱ�����Լ��ٶȣ����ڻ�ͼ 
MDis=zeros(3,length(TA)); MVel=zeros(3,length(TA)); 
MAcc=zeros(3,length(TA));  
j=1;    %����һ��ѭ���п��Ʋ�ͬ������� 
for Damp=[0.1,0.15,0.2]          
    t=1;    %����һ��ѭ���п��Ʋ�ͬ�Ľṹ��������     
    for T=0.1:0.5:6          
        Frcy=2*pi/T;  %�ṹ����Ƶ��                  
        DamFrcy=Frcy*sqrt(1-Damp*Damp);   %���㹫ʽ����         
        e_t=exp(-Damp*Frcy*Dt);        
        s=sin(DamFrcy*Dt);         
        c=cos(DamFrcy*Dt);                  
        A=zeros(2,2);            
        A(1,1)=e_t*(s*Damp/sqrt(1-Damp*Damp)+c);           
        A(1,2)=e_t*s/DamFrcy;            
        A(2,1)=-Frcy*e_t*s/sqrt(1-Damp*Damp);             
        A(2,2)=e_t*(-s*Damp/sqrt(1-Damp*Damp)+c);                    
        d_f=(2*Damp^2-1)/(Frcy^2*Dt); %���㹫ʽ����        
        d_3t=Damp/(Frcy^3*Dt);                          
        B=zeros(2,2);             
        B(1,1)=e_t*((d_f+Damp/Frcy)*s/DamFrcy+(2*d_3t+1/Frcy^2)*c)-2*d_3t;             
        B(1,2)=-e_t*(d_f*s/DamFrcy+2*d_3t*c)-1/Frcy^2+2*d_3t;             
        B(2,1)=e_t*((d_f+Damp/Frcy)*(c-Damp/sqrt(1-Damp^2)*s)-(2*d_3t+1/Frcy^2)*(DamFrcy*s+Damp*Frcy*c))+1/(Frcy^2*Dt);              B(2,2)=e_t*(1/(Frcy^2*Dt)*c+s*Damp/(Frcy*DamFrcy*Dt))-1/(Frcy^2*Dt); 
        for i=1:(count-1)    %���ݵ����¼,���㲻ͬ�ķ�Ӧ            
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
        Displace=zeros(1,count);%��ʼ�������������������´β�ͬ���ڼ���ʱ���õ�ǰһ�����ڵĽ��         
        Velocity=zeros(1,count);        
        AbsAcce=zeros(1,count);                 
        t=t+1;     
    end
    j=j+1; 
end  % ***********PLOT*********** close all  figure %���Ƶ����¼ͼ 
plot(time(:),Accelerate(:))     
title('PEER STRONG MOTION DATABASE RECORD--CHI010') 
xlabel('time(s)')  
ylabel('acceleration(g)') 
grid  
figure %����λ�Ʒ�Ӧ��   
plot(TA,MDis(1,:),'-.b',TA,MDis(2,:),'-r',TA,MDis(3,:),':k') 
title('Displacement') 
xlabel('Tn(s)') 
ylabel('Displacement(m)')  
legend('��=0','��=0.05','��=0.1')
grid 
figure %�����ٶȷ�Ӧ��   
plot(TA,MVel(1,:),'-.b',TA,MVel(2,:),'-r',TA,MVel(3,:),':k') 
title('Velocity') 
xlabel('Tn(s)')  
ylabel('velocity(m/s)')  
legend('��=0','��=0.05','��=0.1') 
grid  
figure %���ƾ��Լ��ٶȷ�Ӧ��   
plot(TA,MAcc(1,:),'-.b',TA,MAcc(2,:),'-r',TA,MAcc(3,:),':k') 
title('Absolute Acceleration') 
xlabel('Tn(s)')  
ylabel('absolute acceleration(m/s^2)') 
legend('��=0','��=0.05','��=0.1') 
grid  figure %���Ʊ�׼���ٶȷ�Ӧ��   
M=max(abs(Accelerate)); %�����¼���ֵ  
plot(TA,MAcc(1,:)/M,'-.b',TA,MAcc(2,:)/M,'-r',TA,MAcc(3,:)/M,':k') 
title('Normalized Absolute Acceleration') 
xlabel('Tn(s)')  
ylabel('Normalized absolute acceleration') 
legend('��=0','��=0.05','��=0.1') 
grid  
%%%%%%%%%%%%%%%%%%%%% End With  matlab6.5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%