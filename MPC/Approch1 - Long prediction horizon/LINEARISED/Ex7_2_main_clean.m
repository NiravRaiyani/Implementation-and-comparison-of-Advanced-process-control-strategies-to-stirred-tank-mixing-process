clear all;
clc;

%% defind global variables that will be used in the other two functions
global Ad Bd Cd N Q R umax 

%% Model
Ad = [-0.0075 0; 0 -0.015]; 
Bd = [1 1; -22.33 44.66]; 
Cd = [-2/3 1];

%% MPC Parameters
Q = [1 0;0 17956];
R = [1 0; 0 1];
N = 4; % prediction Horizon 
umax = 0.5; % input bound

%% Simulation 
tf = 25; % simulation length
xd(:,1) = [0.1,0.1]; % initial condition

for k = 1:tf
    U = ExampleMPC(xd(:,k)); 
    u(:,k) = U(1,1:2)';
    xd(:,k+1) = Ad*xd(:,k)+Bd*u(:,k);
end

%% Calculating the total cost
V=0;
for i=1:size(xd,2)-1
    xk=xd(:,i);
    V=V+xk'*Q*xk + u(i)'*R*u(i);
end
%Add the terminal state cost
xk=xd(:,end);
V=V+xk'*Q*xk;  %same Q is used here

%% Plot results
figure('Position',[450 291 400 300])
kaxis = 0:tf;
subplot(2,1,1)
plot(kaxis,xd,'+-')
ylabel('x')
%title(['Total cost of MPC with N=' num2str(N) ' is ' num2str(V)])
% axis([0 tf -0.55 0.05])
subplot(2,1,2)
stairs(kaxis(1:end-1),u,'+-')
xlabel('Time (k)')
ylabel('u')


ka=0:(tf-1)
stairs(ka,u)
