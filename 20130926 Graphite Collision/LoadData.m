function [varargout]=LoadData(filepath)
% 读取LMS导出的数据
% 
load(filepath);
text={'P1+X','P2+Y','P3+Z','P4+X','P5+Y','P6+Z','P7','P8','P9'};

Sv=Signal_0.x_values.start_value;
Ic=Signal_0.x_values.increment;
Nv=Signal_0.x_values.number_of_values;
time=Sv:Ic:(Nv)*Ic;

data(1:Nv,1:7)=Signal_0.y_values.values;
data(1:Nv,8:9)=Signal_1.y_values.values;
varargout{1}=time;
varargout{2}=data;
varargout{3}=text;

end