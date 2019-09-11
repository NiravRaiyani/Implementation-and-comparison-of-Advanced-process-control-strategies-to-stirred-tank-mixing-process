clear all;
close all;
clc;

%%global variables that will be used in the other two functions
global  N Q R umax xs us

%% MPC Parameters
Q = [1 0; 0 1/400];
R = [1 0; 0 1];
N = 12; % prediction Horizon 
umax = 0.03; % INPUT Constriant
xs=[1.1 ; 842]; %Steady - state STATE VARIABLE
us=[0.01; 0.005]; % Steady - state INPUT VARIABLES


%% Simulation 
tf = 35; % simulation length
xd(:,1) = [1; 840]; % initial condition of STATE
ts = 1;

for k = 1:tf
    U = Optimizer_1(xd(:,k)); 
    u(1:2,k) = U(1,1:2)';
    % diff1 integrates the nonlinear system equation for 1 time instant
    xd(:,k+1) = diff1(xd(:,k),u(1:2,k)); 
   
end

%% Calculating the total cost
V=0;
for i=1:size(xd,2)-1
    xk=xd(:,i);
    V=V+(xk-xs)'*Q*(xk-xs) + (u(1:2,i)-us)'*R*(u(1:2,i)-us);
end
%Add the terminal state cost
xk=xd(:,end);
V=V+(xk-xs)'*Q*(xk-xs);  %same Q is used here

%% Plot results
figure('Position',[450 291 400 300])
kaxis = 0:tf;
subplot(2,2,1)
plot(kaxis,xd(1,:),'-+','linewidth',2)
xlabel('t')
ylabel('x_{1} - V')
axis([0 tf 0.8 1.3])
%text(20,0.9,'Q = [1 0; 0 0.0025] & R = [0.5 0; 0 0.5]')
title([' Initial V =' num2str(xd(1,1)) ' &   Setpoint V = ' num2str(xs(1,1))])
subplot(2,2,2)
plot(kaxis,xd(2,:),'-+','linewidth',2)
xlabel('t')
ylabel('x_{2} - \rho')
axis([0 tf 840 843])
%text(20,842,'Q = [1 0; 0 0.0025] & R = [0.5 0; 0 0.5]')

title([' Initial \rho =' num2str(xd(2,1)) ' &   Setpoint \rho = ' num2str(xs(2,1))])

%axis([0 tf -0.55 0.05])
subplot(2,2,3)
stairs(0:(tf-1),u(1,:),'-','linewidth',2)
xlabel('t')
ylabel('u_{1} - F_{1}')
axis([0 tf 0 0.03])
title(['Total cost of MPC(Approch-1) with N=' num2str(N) ' is ' num2str(V)])
subplot(2,2,4)
stairs(0:(tf-1),u(2,:),'-','linewidth',2)
xlabel('t')
ylabel('u_{2} - F_{2}')
axis([0 tf 0 0.03])
title(['Total cost of MPC(Approch-1) with N=' num2str(N) ' is ' num2str(V)])