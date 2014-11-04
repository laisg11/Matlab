function Nodes=loadnodes(NODES_FROM_ABQ)
% 输入节点信息，输出节点
  [a,b]=size(NODES_FROM_ABQ);
  if b~=4
      error('NODES_FROM_ABQ 数据有误');
  end
  for i=1:a
      n=NODES_FROM_ABQ(i,1);
      Nodes(n).number=n;
      Nodes(n).coord=NODES_FROM_ABQ(i,2:4);
      Nodes(n).U=[0,0,0];
      Nodes(n).V=[0,0,0];
      Nodes(n).A=[0,0,0];
  end
end