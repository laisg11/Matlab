function Nodes=insert_nodes_data(Nodes,U,V,A)
a=length(Nodes);
[b,c]=size(U);
if a*3~=b
    error('节点数和自由度不匹配');
end

for i=1:a
    Nodes(i).U(1)=U(i*3-3+1,c);
    Nodes(i).U(2)=U(i*3-3+2,c);
    Nodes(i).U(3)=U(i*3-3+3,c);
    
    Nodes(i).V(1)=V(i*3-3+1,c);
    Nodes(i).V(2)=V(i*3-3+2,c);
    Nodes(i).V(3)=V(i*3-3+3,c);
    
    Nodes(i).A(1)=A(i*3-3+1,c);
    Nodes(i).A(2)=A(i*3-3+2,c);
    Nodes(i).A(3)=A(i*3-3+3,c);
end

end