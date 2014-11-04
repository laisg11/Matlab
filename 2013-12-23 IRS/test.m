clear
clc
load Data
Mr=M_Fine;
Kr=K_Fine;

w=0:0.1:50;
for i=1:length(w)
    y(i)=abs(det(-w(i)*w(i)*Mr*1000+Kr/1000));
    if y(i)<=0.01
        disp(w(i))
    end
end