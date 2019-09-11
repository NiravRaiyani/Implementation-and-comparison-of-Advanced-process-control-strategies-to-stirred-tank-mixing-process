function xd = diff1(x,u)
ts=0.1;

for i= 1:1:9
    x(1,i+1) = x(1,i) + (u(1,1) + u(2,1) - 0.015*sqrt(x(1,i)))*ts;
    x(2,i+1) = x(2,i) + ((1/x(1,i))*((823 - x(2,i))*u(1,1) + (890 - x(2,i))*u(2,1)))*ts;
end
xd = x(:,end);
end