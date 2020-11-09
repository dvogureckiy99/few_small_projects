a = [2 5 6 2 1 0];

c = zeros(3,5);
lamda = zeros(1,5);
lambda(3)=a(1)/a(1);
c(1,1)=a(1);
c(2,1)=a(3);
c(3,1)=a(5);
c(1,2)=a(2);
c(2,2)=a(4);
c(3,2)=a(6);
c(1,3)=a(3)-lambda(3)*a(4);
lambda(4)=a(2)/c(1,3);
c(2,3)=a(5)-lambda(3)*a(5);
c(1,4)=a(4)-lamda(4)*c(2,3);
lambda(5)=c(1,3)/c(1,4);
c(1,5)=c(2,3)-lambda(5)*c(2,4);

RausCell = {'Номер строки','Значение \lambda','1','2','3';
            1,0,c(1,1),c(2,1),c(3,1);
            2,0,c(1,2),c(2,2),c(3,2);
            3,lambda(3),c(1,3),c(2,3),c(3,3);
            4,lambda(4),c(1,4),c(2,4),c(3,4);
            5,lambda(5),c(1,5),c(2,5),c(3,5)}
        
if lambda(3) > 0 && lambda(4) > 0 && lambda(5) > 0
   disp("устойчива");
else
   disp("неустойчива");
end
%RausTable = cell2table(RausCell(2:length(RausCell),:))
