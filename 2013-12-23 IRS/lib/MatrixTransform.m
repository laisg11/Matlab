function [Kr,Mr]=MatrixTransform(Minp,Kinp,Nodes,G)

% �����ӽṹ�ĳ�����Ԫ��
% �����������ն���ı���
% IRS

% ���ȱ任��ʹ�����һ����ʽ
% -        -     -        -
%| Kmm  Kms |   | Mmm  Mms |
%| Ksm  Kss |   | Msm  Mss |
% -        -     -        -
[m,n]=size(Minp);
Mout=Minp;
Kout=Kinp;
L=length(Nodes);
for i=1:L
    for j=1:3
        I=eye(m,n);
        I(i*3-3+j,i*3-3+j)=0;
        I(Nodes(i)*3-3+j,Nodes(i)*3-3+j)=0;
        I(i*3-3+j,Nodes(i)*3-3+j)=1;
        I(Nodes(i)*3-3+j,i*3-3+j)=1;
        Mout=I*Mout*I;
        Kout=I*Kout*I;
    end
end


Kmm=Kout(1:L*3,1:L*3);
Kms=Kout(1:L*3,L*3+1:end);
Ksm=Kout(L*3+1:end,1:L*3);
Kss=Kout(L*3+1:end,L*3+1:end);
Mmm=Mout(1:L*3,1:L*3);
Mms=Mout(1:L*3,L*3+1:end);
Msm=Mout(L*3+1:end,1:L*3);
Mss=Mout(L*3+1:end,L*3+1:end);

% IRS��
Td(1:L*3,1:L*3)=eye(L*3);
Td(L*3+1:m,1:L*3)=-inv(Kss-G*G*Mss)*(Ksm-G*G*Msm);
Ts(1:L*3,1:L*3)=eye(L*3);
Ts(L*3+1:m,1:L*3)=-inv(Kss)*(Ksm);
Ms=Ts'*Mout*Ts;
Ks=Ts'*Kout*Ts;

S(m,m)=0;S(L*3+1:end,L*3+1:end)=inv(Kss-G*G*Mss);
Tirs=Td+S*Mout*Td*inv(Ms)*Ks;


Kr=Tirs'*Kout*Tirs;
Mr=Tirs'*Mout*Tirs;

% Guyan ��̬���۷�
% Kr=Kmm-Kms/Kss*Ksm;
% Mr=1;
end