clear
clc
syms RHS M A
M(10,10)=1;A(10)=1;RHS(10,2)=0;
f=RHS(:,2)-M*A;
fortran(f)