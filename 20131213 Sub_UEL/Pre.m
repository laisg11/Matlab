clear 
clc
submat = importfile('sub_mat.mtx');

data=submat;

[a,b]=size(data);
k=1;
for i=1:a
    for j=1:b
        if ~isnan(data(i,j))
            temp(k)=data(i,j);
            k=k+1;
        end
    end
end

k=1;
for i=1:24
    for j=1:i
        K(i,j)=temp(k);
        K(j,i)=temp(k);
        k=k+1;
    end
end
fileID = fopen('K.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',K);
fclose(fileID);
        