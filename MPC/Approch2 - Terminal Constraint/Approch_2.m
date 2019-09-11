clear all
clc

global N Q R umax xs us

%% MPC Parameters
Q = [1 0; 0 1/400];
R = [1 0; 0 1];
N = 13; % prediction Horizon 
umax = 0.03; % INPUT Constriant
xs=[0.85 ; 842];%Steady - state STATE VARIABLE
us=[0.01; 0.005];% Steady - state INPUT VARIABLE


%% Simulation settings
tf = 20; % simulation length
xd(:,1) = [0.8; 841]; % initial condition
ts = 1;

for k = 1:tf
    disp(['Time ' num2str(k) ' starts']) % show messages
    U = ExampleMPC2(xd(:,k)); 
    u(1:2,k) = U(1,1:2)';
    xd(:,k+1) = diff1(xd(:,k),u(1:2,k));
    % diff1 integrates the nonlinear system equation for 1 time instant
    disp(['Time ' num2str(k) ' completed'])
end


%% Calculating the total cost
V=0;
for i=1:size(xd,2)-1
    xk=xd(:,i);
    V=V+(xk-xs)'*Q*(xk-xs) + (u(1:2,i)-us)'*R*(u(1:2,i)-us);
end
xk=xd(:,end);
V=V+(xk-xs)'*Q*(xk-xs);  

%% Plot results
figure('Position',[450 291 400 300])
kaxis = 0:tf;
subplot(2,2,1)
plot(kaxis,xd(1,:),'-+','linewidth',2)
xlabel('t')
ylabel('x_{1} - V')
axis([0 tf 0.8 0.95])
%text(20,0.9,'Q = [1 0; 0 0.0025] & R = [0.5 0; 0 0.5]')
title([' Initial V =' num2str(xd(1,1)) ' &   Steady-state V = ' num2str(xs(1,1))])
subplot(2,2,2)
plot(kaxis,xd(2,:),'-+r','linewidth',2)
xlabel('t')
ylabel('x_{2} - \rho')
axis([0 tf 841 842.5])
%text(20,842,'Q = [1 0; 0 0.0025] & R = [0.5 0; 0 0.5]')

title([' Initial \rho =' num2str(xd(2,1)) ' &   Steady-state \rho = ' num2str(xs(2,1))])

%axis([0 tf -0.55 0.05])
subplot(2,2,3)
stairs(0:(tf-1),u(1,:),'-k','linewidth',2)
xlabel('t')
ylabel('u_{1} - F_{1}')
axis([0 tf 0 0.03])
title(['Total cost of MPC(Approch-2) with N=' num2str(N) ' is ' num2str(V)])
subplot(2,2,4)
stairs(0:(tf-1),u(2,:),'-k','linewidth',2)
xlabel('t')
ylabel('u_{2} - F_{2}')
axis([0 tf 0 0.03])
title(['Total cost of MPC(Approch-2) with N=' num2str(N) ' is ' num2str(V)])






