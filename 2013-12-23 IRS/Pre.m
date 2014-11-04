clear 
clc
addpath('Data')
load DataFromABQ

s=KFromABQ(end,1);
K_Fine(s,s)=0;
s=MFromABQ(end,1);
M_Fine(s,s)=0;

for i=1:length(KFromABQ)
    K_Fine(KFromABQ(i,1),KFromABQ(i,2))=KFromABQ(i,3);
end

for i=1:length(MFromABQ)
    M_Fine(MFromABQ(i,1),MFromABQ(i,2))=MFromABQ(i,3);
end

save Data K_Fine M_Fine