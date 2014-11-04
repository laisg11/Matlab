function Elements=loadelements(ElEMENTS_FROM_ABQ)
% 输入单元信息，输出单元结构体
  [a,b]=size(ElEMENTS_FROM_ABQ);
  if b~=9
      error('ElEMENTS_FROM_ABQ 数据有误');
  end
  for i=1:a
      n=ElEMENTS_FROM_ABQ(i,1);
      Elements(n).number=n;
      Elements(n).nodes=ElEMENTS_FROM_ABQ(i,2:9);
      Elements(n).U=[0,0,0];
      Elements(n).V=[0,0,0];
      Elements(n).A=[0,0,0];
  end

end