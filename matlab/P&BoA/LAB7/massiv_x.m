function  x = massiv_x(h)
n=30/h+1;%количесвто элементов;
x=zeros(1,n);
i=2;
while i<=n
    x(i) =  x(i-1)+h;
    i=i+1;
end
end