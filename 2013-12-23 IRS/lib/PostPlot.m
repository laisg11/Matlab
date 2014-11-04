function PostPlot(temp,U,scale)
    loc=temp;
    %loc(9:16,1:3)=temp;
    X=loc(:,1);
    Y=loc(:,2);
    Z=loc(:,3);
    for i=1:8
     u(i)=U(i*3-2);
     v(i)=U(i*3-1);
     w(i)=U(i*3);
    end
    X2=X+u'*scale;
    Y2=Y+v'*scale;
    Z2=Z+w'*scale;
    
    scatter3(X,Y,Z,'filled')
    hold on
    scatter3(X2,Y2,Z2)
    axis([-50 150 -30 30 -20 80])
    
    line([X2(5) X2(6)],[Y2(5) Y2(6)],[Z2(5) Z2(6)],'Color','g','linewidth',2)
    line([X2(5) X2(1)],[Y2(5) Y2(1)],[Z2(5) Z2(1)],'Color','g','linewidth',2)
    line([X2(5) X2(8)],[Y2(5) Y2(8)],[Z2(5) Z2(8)],'Color','g','linewidth',2)
    line([X2(7) X2(3)],[Y2(7) Y2(3)],[Z2(7) Z2(3)],'Color','g','linewidth',2)
    line([X2(7) X2(8)],[Y2(7) Y2(8)],[Z2(7) Z2(8)],'Color','g','linewidth',2)
    line([X2(7) X2(6)],[Y2(7) Y2(6)],[Z2(7) Z2(6)],'Color','g','linewidth',2)
    line([X2(2) X2(1)],[Y2(2) Y2(1)],[Z2(2) Z2(1)],'Color','g','linewidth',2)
    line([X2(2) X2(3)],[Y2(2) Y2(3)],[Z2(2) Z2(3)],'Color','g','linewidth',2)
    line([X2(2) X2(6)],[Y2(2) Y2(6)],[Z2(2) Z2(6)],'Color','g','linewidth',2)
    line([X2(4) X2(3)],[Y2(4) Y2(3)],[Z2(4) Z2(3)],'Color','g','linewidth',2)
    line([X2(4) X2(8)],[Y2(4) Y2(8)],[Z2(4) Z2(8)],'Color','g','linewidth',2)
    line([X2(4) X2(1)],[Y2(4) Y2(1)],[Z2(4) Z2(1)],'Color','g','linewidth',2)
    
%     line([X2(5+8) X2(6+8)],[Y2(5+8) Y2(6+8)],[Z2(5+8) Z2(6+8)],'Color','g','linewidth',2)
%     line([X2(5+8) X2(1+8)],[Y2(5+8) Y2(1+8)],[Z2(5+8) Z2(1+8)],'Color','g','linewidth',2)
%     line([X2(5+8) X2(8+8)],[Y2(5+8) Y2(8+8)],[Z2(5+8) Z2(8+8)],'Color','g','linewidth',2)
%     line([X2(7+8) X2(3+8)],[Y2(7+8) Y2(3+8)],[Z2(7+8) Z2(3+8)],'Color','g','linewidth',2)
%     line([X2(7+8) X2(8+8)],[Y2(7+8) Y2(8+8)],[Z2(7+8) Z2(8+8)],'Color','g','linewidth',2)
%     line([X2(7+8) X2(6+8)],[Y2(7+8) Y2(6+8)],[Z2(7+8) Z2(6+8)],'Color','g','linewidth',2)
%     line([X2(2+8) X2(1+8)],[Y2(2+8) Y2(1+8)],[Z2(2+8) Z2(1+8)],'Color','g','linewidth',2)
%     line([X2(2+8) X2(3+8)],[Y2(2+8) Y2(3+8)],[Z2(2+8) Z2(3+8)],'Color','g','linewidth',2)
%     line([X2(2+8) X2(6+8)],[Y2(2+8) Y2(6+8)],[Z2(2+8) Z2(6+8)],'Color','g','linewidth',2)
%     line([X2(4+8) X2(3+8)],[Y2(4+8) Y2(3+8)],[Z2(4+8) Z2(3+8)],'Color','g','linewidth',2)
%     line([X2(4+8) X2(8+8)],[Y2(4+8) Y2(8+8)],[Z2(4+8) Z2(8+8)],'Color','g','linewidth',2)
%     line([X2(4+8) X2(1+8)],[Y2(4+8) Y2(1+8)],[Z2(4+8) Z2(1+8)],'Color','g','linewidth',2)
end