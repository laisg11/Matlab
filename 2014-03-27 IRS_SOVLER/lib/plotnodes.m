function plotnodes(Nodes,Scale)
a=length(Nodes);
for i=1:a
   %N(i,1:3)=Nodes(i).coord;
   N(i,1:3)=Scale*Nodes(i).U+Nodes(i).coord;
   C(i,1:3)=Scale*Nodes(i).U;
end
% s(1:a)=1:a;
% c=repmat(Nodes(:,1),numel(N),1);
% scatter3(N(:,1),N(:,2),N(:,3),s,c);
scatter3(N(:,1),N(:,2),N(:,3),5,abs(C)/(max(max(abs(C)))),'filled');
axis([0,150,-75,75,-10,140])
end