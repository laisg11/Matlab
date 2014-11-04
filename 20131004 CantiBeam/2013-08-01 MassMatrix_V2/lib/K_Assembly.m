function K=K_Assembly(Elements,SK)
SM1=Elements(1).K;
SM2=Elements(1).K;
K(48,48)=0;
K(1:24,1:24)=SM1;
K(25:48,25:48)=SM2;
for i=1:3:10
    K(i,i)=K(i,i)+SK(1);
    K(36+i,36+i)=K(36+i,36+i)+SK(1);
    K(i,i+36)= K(i,i+36)-SK(1);%1-5
    K(i+36,i)= K(i+36,i)-SK(1);
end
for i=2:3:11
    K(i,i)=K(i,i)+SK(2);
    K(36+i,36+i)=K(36+i,36+i)+SK(2);
    K(i,i+36)= K(i,i+36)-SK(2);%1-5
    K(i+36,i)= K(i+36,i)-SK(2);
end
for i=3:3:12
    K(i,i)=K(i,i)+SK(3);
    K(36+i,36+i)=K(36+i,36+i)+SK(3);
    K(i,i+36)= K(i,i+36)-SK(3);%1-5
    K(i+36,i)= K(i+36,i)-SK(3);
end

end